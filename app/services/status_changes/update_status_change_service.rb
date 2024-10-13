# frozen_string_literal: true

module StatusChanges
  # This service updates a status change for the project.
  class UpdateStatusChangeService < ActiveInteraction::Base
    attr_reader :status_change

    object :status_change, class: StatusChange
    object :user, class: User
    object :project, class: Project
    string :status

    # Executes the service to update the status change and send a notification.
    # @return [StatusChange] The updated status change.
    def execute
      ActiveRecord::Base.transaction do
        update_status_change
        create_notification if status_change.persisted?
      end

      status_change
    end

    private

    # Update the existing status change
    def update_status_change
      status_change.status = status
      status_change.user = user  # Update the user who made the status change

      # Save the status change and capture any validation errors
      errors.merge!(status_change.errors) unless status_change.save
    end

    # Create a notification when the status is updated
    def create_notification
      Notifications::CreateService.run(
        trackable: status_change,
        project: project,
        user: user,
        message: "Status updated to '#{status_change.status}' for project '#{project.title}'"
      )
    end
  end
end
