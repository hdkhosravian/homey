class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :projects, dependent: :destroy  # Projects that the user owns
  has_many :comments, dependent: :destroy  # Comments made by the user
  has_many :notifications, dependent: :destroy
end
