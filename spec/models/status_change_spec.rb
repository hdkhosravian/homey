require 'rails_helper'

RSpec.describe StatusChange, type: :model do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:status_change) { create(:status_change, user: user, project: project, status: :in_progress) }

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:project) }
  end

  describe "validations" do
    it { should validate_presence_of(:status) }
  end

  describe "enums" do
    it "defines the correct statuses" do
      expect(StatusChange.statuses).to eq({
        "not_started" => "Not Started",
        "in_progress" => "In Progress",
        "on_hold" => "On Hold",
        "completed" => "Completed"
      })
    end
  end

  describe "creation" do
    it "is valid with valid attributes" do
      expect(status_change).to be_valid
    end
  end
end
