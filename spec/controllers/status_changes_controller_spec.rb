require 'rails_helper'

RSpec.describe StatusChangesController, type: :controller do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let!(:status_change) { create(:status_change, project: project, user: user, status: 'not_started') }

  before { sign_in user }

  describe "GET #edit" do
    context "when user is the owner" do
      it "renders the edit form for the project's status change" do
        get :edit, params: { project_id: project.id }

        expect(response).to render_template(:edit)
        expect(assigns(:project)).to eq(project)
        expect(assigns(:status_change)).to eq(status_change)
      end
    end

    context "when user is not the owner" do
      before { sign_in another_user }

      it "denies access and redirects" do
        get :edit, params: { project_id: project.id }
        expect(response).to have_http_status(:redirect)
        expect(flash[:alert]).to eq("You are not authorized to perform this action.")
      end
    end
  end

  describe "PATCH #update" do
    context "when user is the owner" do
      it "updates the status change and redirects to the project page" do
        patch :update, params: { project_id: project.id, status_change: { status: 'in_progress' } }
        expect(response).to redirect_to(project_path(project))
        expect(status_change.reload.status).to eq('in_progress')
      end
    end

    context "when user is not the owner" do
      before { sign_in another_user }

      it "denies access and does not update the status" do
        patch :update, params: { project_id: project.id, status_change: { status: 'in_progress' } }
        expect(response).to have_http_status(:redirect)
        expect(flash[:alert]).to eq("You are not authorized to perform this action.")
        expect(status_change.reload.status).to eq('not_started')
      end
    end
  end
end
