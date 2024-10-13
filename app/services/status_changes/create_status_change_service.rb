# frozen_string_literal: true

module StatusChanges
  # This service creates a status change for the project.
  class CreateStatusChangeService < ActiveInteraction::Base
    attr_reader :status_change

    object :project, class: Project
    object :user, class: User
    string :status, default: "not_started"

    # Executes the service to create a status change.
    # @return [StatusChange] The newly created status change.
    def execute
      ActiveRecord::Base.transaction do
        create_status_change
        create_notification if status_change.persisted?
      end

      status_change
    end

    private

    def create_status_change
      @status_change = StatusChange.new(
        status: status,
        project: project,
        user: user
      )

      errors.merge!(status_change.errors) unless status_change.save
    end

    # Create a notification when the status is assigned
    def create_notification
      Notifications::CreateService.run(
        trackable: status_change,
        project: project,
        user: user,
        message: "Status '#{status_change.status}' assigned to project '#{project.title}'"
      )
    end
  end
end
