class Notification < ApplicationRecord
  # Associations
  belongs_to :trackable, polymorphic: true  # This allows the notification to track changes in multiple models
  belongs_to :user  # The user who triggered the notification
  belongs_to :project  # The project who triggered the notification

  # Attributes:
  # - message: Describes the notification event (string)
  # - trackable: A polymorphic reference to the object being tracked (project, status change, etc.)
  # - user: The user who caused the notification (references)
  # - project: The project who caused the notification (references)
end
