require 'rails_helper'

RSpec.describe ProjectPolicy, type: :policy do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:project) { create(:project, user: user) }

  subject { described_class }

  permissions :edit?, :update?, :destroy? do
    it "grants access if user is the project owner" do
      expect(subject).to permit(user, project)
    end

    it "denies access if user is not the project owner" do
      expect(subject).not_to permit(other_user, project)
    end
  end
end
