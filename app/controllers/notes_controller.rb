class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_note, only: [:edit, :update, :show, :destroy]

  def index
    @notes = Note.all.order("updated_at desc").paginate(page: params[:page], per_page: 5)
  end

  def new
    @note = Note.new
  end

  def create
    @note = current_user.notes.create(notes_params)
    if @note.present?
      validate_tags(@note, params[:tags])
			redirect_to notes_path, notice: 'Note Created Successfully.'
		else
      flash[:notice] = @note.errors.full_messages.first.gsub("Body","")
			render :new
		end
  end

  def edit
  end

  def update
    if @note.update_attributes(notes_params)
      validate_tags(@note, params[:tags])
      redirect_to notes_path, notice: 'Note Updated Successfully.'
    else
      flash[:notice] = @note.errors.full_messages.first.gsub("Body","")
			render :edit
    end
  end

  def show
  end

  def destroy
    if @note.destroy
      redirect_to notes_path, notice: 'Note deleted Successfully.'
    else
      flash[:notice] = @note.errors.full_messages.first.gsub("Body","")
      redirect_to notes_path
    end
  end

  private
  def find_note
    @note = Note.find_by(id: params[:id])
    redirect_to notes_path unless @note
  end
	def notes_params
		params.require(:note).permit(:title,:body)
	end
  def validate_tags(note, tags)
    tags = tags.split(",")
    note.tags.destroy_all
    tags.each do |tag|
      @tag = Tag.find_or_create_by(tag: tag.strip)
      NotesTag.find_or_create_by(note_id: note.id, tag_id: @tag.id)
    end
  end
end
