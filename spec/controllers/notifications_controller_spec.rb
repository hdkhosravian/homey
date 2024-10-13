require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let!(:notification) { create(:notification, trackable: project, user: user, project: project) }

  before { sign_in user }

  describe "GET #index" do
    it "allows access and retrieves all notifications for the project" do
      get :index, params: { project_id: project.id }
      expect(response).to have_http_status(:success)
      expect(assigns(:notifications)).to eq([ notification ])
    end
  end
end
