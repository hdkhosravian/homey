require 'rails_helper'

RSpec.describe Comments::CreateCommentService, type: :service do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:params) { { content: 'This is a comment' } }

  it "creates a comment and a notification" do
    result = described_class.run(user: user, project: project, params: params)

    expect(result).to be_valid
    comment = Comment.last
    expect(comment.content).to eq('This is a comment')
    expect(comment.project).to eq(project)

    notification = Notification.last
    expect(notification.trackable).to eq(comment)
    expect(notification.message).to eq("New comment created by #{user.email} on project '#{project.title}'")
  end

  it "fails when content is missing" do
    result = described_class.run(user: user, project: project, params: { content: '' })
    expect(result).to be_invalid
    expect(result.errors.full_messages).to include("Content can't be blank")
  end
end
