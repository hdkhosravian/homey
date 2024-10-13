require 'rails_helper'

RSpec.describe CommentPolicy do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:comment) { create(:comment, project: project, user: user) }

  subject { described_class }

  permissions :edit?, :update?, :destroy? do
    context "when user is the project owner" do
      it "grants access" do
        expect(subject).to permit(user, comment)
      end
    end

    context "when user is the comment author" do
      let(:comment_author) { create(:user) }
      let(:comment) { create(:comment, project: project, user: comment_author) }

      it "grants access" do
        expect(subject).to permit(comment_author, comment)
      end
    end

    context "when user is neither the owner nor the author" do
      it "denies access" do
        expect(subject).not_to permit(another_user, comment)
      end
    end
  end
end
