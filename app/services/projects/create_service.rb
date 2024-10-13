# frozen_string_literal: true

module Projects
  # This service is responsible for creating new projects.
  class CreateService < ActiveInteraction::Base
    attr_reader :project

    object :user, class: User
    hash :params, strip: false

    # Executes the service to create a new project.
    # @return [Project] The newly created project.
    def execute
      ActiveRecord::Base.transaction do
        create_a_project
        create_status_change if project.persisted?
      end

      project
    end

    private

    # Create a new project based on the provided parameters.
    def create_a_project
      return if errors.present?

      @project = Project.new
      project.title = params[:title]
      project.description = params[:description]
      project.user = user  # Link the project to the user

      # Save the project and handle errors
      errors.merge!(project.errors) unless project.save
    end

    # Call the service to create a status change with notification
    def create_status_change
      status_change_result = StatusChanges::CreateStatusChangeService.run(
        project: project,
        user: user,
        status: "not_started"
      )

      # Merge errors if the status change or notification fails
      errors.merge!(status_change_result.errors) unless status_change_result.valid?
    end
  end
end
