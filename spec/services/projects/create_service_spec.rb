require 'rails_helper'

RSpec.describe Projects::CreateService, type: :service do
  let(:user) { create(:user) }

  context "when given valid parameters" do
    let(:params) { { title: 'New Project', description: 'Project description' } }

    it "creates a new project" do
      result = described_class.run(user: user, params: params)
      expect(result).to be_valid
      expect(Project.last.title).to eq('New Project')
      expect(Project.last.user).to eq(user)
    end
  end

  context "when given invalid parameters" do
    let(:invalid_params) { { title: '' } }  # Title is required

    it "fails to create a new project and adds errors" do
      result = described_class.run(user: user, params: invalid_params)
      expect(result).to be_invalid
      expect(result.errors.full_messages).to include("Title can't be blank")
    end
  end
end
