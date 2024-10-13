class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment, :project

  def initialize(user, comment)
    @user = user
    @comment = comment
    @project = comment.project
  end

  # Only the author of the comment or the project owner can edit or delete the comment
  def edit?
    owner_or_author?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  private

  def owner_or_author?
    project.user == user || comment.user == user
  end
end
