class StatusChangesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_status_change, only: [ :edit, :update ]
  before_action :authorize_status_change, only: [ :edit, :update ]  # Pundit authorization

  # GET /projects/:project_id/status_change/edit
  def edit
    # Render edit form for status change
  end

  # PATCH /projects/:project_id/status_change
  def update
    result = StatusChanges::UpdateStatusChangeService.run(
      status_change: @status_change,
      user: current_user,
      project: @project,
      status: status_params[:status]
    )

    if result.valid?
      redirect_to project_path(@project), notice: "Project status successfully updated."
    else
      flash[:alert] = result.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_status_change
    @status_change = @project.status_change || @project.build_status_change(user: current_user)
  end

  def status_params
    params.require(:status_change).permit(:status)
  end

  # Pundit authorization for status change
  def authorize_status_change
    authorize @status_change
  end
end
