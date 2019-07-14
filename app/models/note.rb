class Note < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags, dependent: :destroy
  validates :title, :body, presence: true

end
