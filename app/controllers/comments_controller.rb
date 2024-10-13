class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :authorize_comment, only: [:edit, :update, :destroy]  # Pundit authorization

  # GET /projects/:project_id/comments
  def index
    @comments = @project.comments
  end

  # POST /projects/:project_id/comments
  def create
    result = Comments::CreateCommentService.run(
      user: current_user,
      project: @project,
      params: comment_params
    )

    if result.valid?
      redirect_to project_comments_path(@project), notice: 'Comment successfully created.'
    else
      flash[:alert] = result.errors.full_messages.to_sentence
      redirect_to project_comments_path(@project)
    end
  end

  # GET /projects/:project_id/comments/:id/edit
  def edit
    # Render edit form for the comment
  end

  # PATCH/PUT /projects/:project_id/comments/:id
  def update
    result = Comments::UpdateCommentService.run(
      user: current_user,
      comment: @comment,
      params: comment_params
    )

    if result.valid?
      redirect_to project_comments_path(@project), notice: 'Comment successfully updated.'
    else
      flash[:alert] = result.errors.full_messages.to_sentence
      render :edit
    end
  end

  # DELETE /projects/:project_id/comments/:id
  def destroy
    @comment.destroy
    redirect_to project_comments_path(@project), notice: 'Comment successfully deleted.'
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_comment
    @comment = @project.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  # Pundit authorization for comment
  def authorize_comment
    authorize @comment
  end
end
