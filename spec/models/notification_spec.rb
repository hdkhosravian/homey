require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:notification) { create(:notification, user: user, trackable: project) }

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:project) }
    it { should belong_to(:trackable) }
  end

  describe "creation" do
    it "is valid with valid attributes" do
      expect(notification).to be_valid
    end
  end
end
