# frozen_string_literal: true

module Notifications
  # This service creates a notification for a comment or status change.
  class CreateService < ActiveInteraction::Base
    object :trackable, class: 'ApplicationRecord'  # The model the notification belongs to (polymorphic)
    object :user, class: User
    object :project, class: Project
    string :message

    # Executes the service to create a notification.
    # @return [Notification] The newly created notification.
    def execute
      create_notification
    end

    private

    def create_notification
      notification = Notification.new(
        message: message,
        trackable: trackable,  # Could be a status change or comment
        project: project,
        user: user
      )

      errors.merge!(notification.errors) unless notification.save
    end
  end
end
