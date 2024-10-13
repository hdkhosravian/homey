require 'rails_helper'

RSpec.describe StatusChangePolicy do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:status_change) { create(:status_change, project: project, user: user, status: 'not_started') }

  subject { described_class }

  permissions :edit?, :update? do
    context "when user is the owner of the project" do
      it "grants access" do
        expect(subject).to permit(user, status_change)
      end
    end

    context "when user is not the owner of the project" do
      it "denies access" do
        expect(subject).not_to permit(another_user, status_change)
      end
    end
  end
end
