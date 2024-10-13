class StatusChange < ApplicationRecord
  # Associations
  belongs_to :project  # The project the status change belongs to
  belongs_to :user     # The user who made the status change
  has_many :notifications, as: :trackable, dependent: :destroy

  # Enum for status
  enum status: {
    not_started: "Not Started",
    in_progress: "In Progress",
    on_hold: "On Hold",
    completed: "Completed"
  }

  # Validations
  validates :status, presence: true

  # Attributes:
  # - status: Current status of the project (enum string)
  # - user: The user who made the status change (references)
  # - project: The project the status change belongs to (references)
end
