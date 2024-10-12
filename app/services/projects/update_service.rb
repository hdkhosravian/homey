# frozen_string_literal: true

module Projects
  # This service is responsible for updating existing projects.
  class UpdateService < ActiveInteraction::Base
    attr_reader :project

    object :user, class: User
    object :project, class: Project
    hash :params, strip: false

    # Executes the service to update an existing project.
    # @return [Project] The updated project.
    def execute
      update_a_project
      project
    end

    private

    # Update the project based on the provided parameters.
    def update_a_project
      return if errors.present?

      project.title = params[:title] if params[:title].present?
      project.description = params[:description] if params[:description].present?

      # Save the project and handle errors
      errors.merge!(project.errors) unless project.save
    end
  end
end
