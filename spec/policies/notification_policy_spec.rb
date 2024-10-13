require 'rails_helper'

RSpec.describe NotificationPolicy do
  let(:user) { create(:user) }
  let(:notification) { create(:notification) }

  subject { described_class }

  permissions :index? do
    it "grants access to view project notifications" do
      expect(subject).to permit(user, notification)
    end
  end
end
