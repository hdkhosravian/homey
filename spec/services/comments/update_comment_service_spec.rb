require 'rails_helper'

RSpec.describe Comments::UpdateCommentService, type: :service do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:comment) { create(:comment, project: project, user: user, content: 'Initial comment') }

  it "updates a comment and sends a notification" do
    result = described_class.run(user: user, comment: comment, params: { content: 'Updated comment' })

    expect(result).to be_valid
    expect(comment.reload.content).to eq('Updated comment')

    notification = Notification.last
    expect(notification.trackable).to eq(comment)
    expect(notification.message).to eq("Comment updated by #{user.email} on project '#{project.title}'")
  end

  it "fails when content is missing" do
    result = described_class.run(user: user, comment: comment, params: { content: '' })
    expect(result).to be_invalid
    expect(result.errors.full_messages).to include("Content can't be blank")
  end
end
