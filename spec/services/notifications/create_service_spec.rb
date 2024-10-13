require 'rails_helper'

RSpec.describe Notifications::CreateService, type: :service do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:status_change) { create(:status_change, project: project, user: user, status: 'in_progress') }

  context "when valid parameters are provided" do
    let(:message) { "Status 'in_progress' assigned to project '#{project.title}'" }

    it "creates a notification" do
      result = described_class.run(trackable: status_change, user: user, project: project, message: message)
      expect(result).to be_valid
      notification = Notification.last
      expect(notification.trackable).to eq(status_change)
      expect(notification.user).to eq(user)
      expect(notification.message).to eq(message)
    end
  end
end
