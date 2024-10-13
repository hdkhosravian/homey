require 'rails_helper'

RSpec.describe StatusChanges::CreateStatusChangeService, type: :service do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }

  context "when valid parameters are provided" do
    it "creates a status change and notification" do
      result = described_class.run(project: project, user: user, status: 'not_started')
      expect(result).to be_valid
      status_change = StatusChange.last
      expect(status_change.project).to eq(project)
      expect(status_change.user).to eq(user)
      expect(status_change.status).to eq('not_started')

      notification = Notification.last
      expect(notification.trackable).to eq(status_change)
      expect(notification.user).to eq(user)
      expect(notification.message).to eq("Status 'not_started' assigned to project '#{project.title}'")
    end
  end

  context "when invalid parameters are provided" do
    it "fails to create a status change" do
      result = described_class.run(project: project, user: user, status: '')  # Invalid status
      expect(result).to be_invalid
      expect(result.errors.full_messages).to include("Status can't be blank")
    end
  end
end
