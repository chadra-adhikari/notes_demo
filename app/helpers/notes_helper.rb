module NotesHelper

  def notes_tags(note)
    note.tags.pluck(:tag).map do |tag|
      "#"+tag
    end
  end
end
