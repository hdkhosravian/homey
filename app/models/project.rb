class Project < ApplicationRecord
  # Associations
  belongs_to :user  # The user who owns the project
  has_one :status_change, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # Validations
  validates :title, presence: true
  validates :description, presence: true

  # Attributes:
  # - title: The title of the project (string)
  # - description: Detailed description of the project (text)
  # - user: The owner or creator of the project (references)
end
