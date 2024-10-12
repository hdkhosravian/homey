class Comment < ApplicationRecord
  # Associations
  belongs_to :project  # The project the comment belongs to
  belongs_to :user     # The user who made the comment (author)

  # Validations
  validates :content, presence: true

  # Attributes:
  # - content: The text of the comment (text)
  # - user: The author of the comment (references)
  # - project: The project the comment belongs to (references)
end
