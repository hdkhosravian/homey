require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:comment) { create(:comment, user: user, project: project) }

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:project) }
    it { should have_many(:notifications).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:content) }
  end

  describe "creation" do
    it "is valid with valid attributes" do
      expect(comment).to be_valid
    end
  end
end
