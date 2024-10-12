class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :projects  # Projects that the user owns
  has_many :comments  # Comments made by the user
  has_many :status_changes  # Status changes made by the user
end
