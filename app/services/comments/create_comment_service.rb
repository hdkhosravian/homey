# frozen_string_literal: true

module Comments
  # This service creates a comment for the project and sends a notification.
  class CreateCommentService < ActiveInteraction::Base
    object :user, class: User
    object :project, class: Project
    hash :params, strip: false

    attr_reader :comment

    # Executes the service to create a comment.
    def execute
      ActiveRecord::Base.transaction do
        create_comment
        create_notification if comment.persisted?
      end
      comment
    end

    private

    def create_comment
      @comment = project.comments.build(
        content: params[:content],
        user: user
      )
      errors.merge!(comment.errors) unless comment.save
    end

    def create_notification
      Notifications::CreateService.run(
        trackable: comment,
        project: project,
        user: user,
        message: "New comment created by #{user.email} on project '#{project.title}'"
      )
    end
  end
end
