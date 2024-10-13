# frozen_string_literal: true

module Comments
  # This service updates a comment and sends a notification about the update.
  class UpdateCommentService < ActiveInteraction::Base
    object :user, class: User
    object :comment, class: Comment
    hash :params, strip: false

    # Executes the service to update a comment.
    def execute
      ActiveRecord::Base.transaction do
        update_comment
        create_notification if comment.persisted?
      end
      comment
    end

    private

    def update_comment
      comment.content = params[:content]
      errors.merge!(comment.errors) unless comment.save
    end

    def create_notification
      Notifications::CreateService.run(
        trackable: comment,
        project: comment.project,
        user: user,
        message: "Comment updated by #{user.email} on project '#{comment.project.title}'"
      )
    end
  end
end
