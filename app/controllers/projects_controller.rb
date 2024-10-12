class ProjectsController < ApplicationController
  before_action :authenticate_user!  # Ensure the user is logged in
  before_action :find_project, only: [:show, :edit, :update, :destroy]
  before_action :authorize_project_owner!, only: [:edit, :update, :destroy]

  # GET /projects
  def index
    @projects = current_user.projects  # List projects for the logged-in user
  end

  # GET /projects/:id
  def show
    # Show a single project (already found by `find_project`)
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # POST /projects
  def create
    result = Projects::CreateService.run(user: current_user, params: project_params)

    if result.valid?
      redirect_to project_path(result.result), notice: "Project successfully created!"
    else
      @project = result.result
      flash[:alert] = result.errors.full_messages.to_sentence
      render :new
    end
  end

  # GET /projects/:id/edit
  def edit
    # Edit a project (already found and authorized)
  end

  # PATCH/PUT /projects/:id
  def update
    result = Projects::UpdateService.run(user: current_user, project: @project, params: project_params)

    if result.valid?
      redirect_to project_path(result.result), notice: "Project successfully updated!"
    else
      @project = result.result
      flash[:alert] = result.errors.full_messages.to_sentence
      render :edit
    end
  end

  # DELETE /projects/:id
  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Project successfully deleted."
  end

  private

  # Strong params
  def project_params
    params.require(:project).permit(:title, :description)
  end

  # Find the project based on ID
  def find_project
    @project = Project.find(params[:id])
  end

  # Pundit authorization for project owner
  def authorize_project_owner!
    authorize @project, :edit?  # Ensures only the owner can edit, update, or destroy
  end
end
