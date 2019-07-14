class Tag < ApplicationRecord
  has_and_belongs_to_many :notes, dependent: :destroy

  validates :tag, presence: true, uniqueness: true
end
