class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project

  # GET /projects/:project_id/notifications
  def index
    authorize Notification  # Pundit authorization for the index action
    @notifications = @project.notifications
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end
end
