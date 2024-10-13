class NotificationPolicy < ApplicationPolicy
  def index?
    true  # Everyone is allowed to view project notifications
  end
end
