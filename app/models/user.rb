class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   def full_name
     "#{first_name} #{last_name}"
   end

   def to_s
     full_name
   end

   has_many :notes, dependent: :destroy

   validates :first_name, :last_name, presence: true
end
