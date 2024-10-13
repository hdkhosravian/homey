require 'rails_helper'

RSpec.describe StatusChanges::UpdateStatusChangeService, type: :service do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:status_change) { create(:status_change, project: project, user: user, status: 'not_started') }

  context "when valid parameters are provided" do
    it "updates the status change and creates a notification" do
      result = described_class.run(status_change: status_change, user: user, project: project, status: 'in_progress')

      expect(result).to be_valid
      expect(status_change.reload.status).to eq('in_progress')

      # Check if notification was created
      notification = Notification.last
      expect(notification.trackable).to eq(status_change)
      expect(notification.message).to eq("Status updated to 'in_progress' for project '#{project.title}'")
    end
  end

  context "when invalid parameters are provided" do
    it "fails to update the status change" do
      result = described_class.run(status_change: status_change, user: user, project: project, status: '')  # Invalid status
      expect(result).to be_invalid
      expect(result.errors.full_messages).to include("Status can't be blank")
    end
  end
end
