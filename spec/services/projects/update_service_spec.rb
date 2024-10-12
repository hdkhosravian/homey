require 'rails_helper'

RSpec.describe Projects::UpdateService, type: :service do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }

  context "when given valid parameters" do
    let(:params) { { title: 'Updated Project Title' } }

    it "updates the project" do
      result = described_class.run(user: user, project: project, params: params)
      expect(result).to be_valid
      expect(project.reload.title).to eq('Updated Project Title')
    end
  end
end
