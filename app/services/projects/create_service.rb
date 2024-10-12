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
      create_a_project
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
  end
end
