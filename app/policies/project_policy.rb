class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  # Only the owner of the project can edit it
  def edit?
    project.user == user
  end

  # Only the owner of the project can update it
  def update?
    edit?
  end

  # Only the owner of the project can destroy it
  def destroy?
    project.user == user
  end
end
