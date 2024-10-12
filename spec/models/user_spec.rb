require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe "associations" do
    it { should have_many(:projects) }
    it { should have_many(:comments) }
    it { should have_many(:status_changes) }
  end

  describe "creation" do
    it "is valid with valid attributes" do
      expect(user).to be_valid
    end
  end
end
