class StatusChangePolicy < ApplicationPolicy
  attr_reader :user, :status_change, :project

  def initialize(user, status_change)
    @user = user
    @status_change = status_change
    @project = status_change.project
  end

  # Only the owner of the project can update the status
  def edit?
    project.user == user
  end

  def update?
    edit?  # Same as edit, only the owner can update
  end
end
