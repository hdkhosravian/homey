require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }

  before { sign_in user }  # Devise helper for signing in a user

  describe "GET #index" do
    it "returns a success response and assigns user's projects" do
      get :index
      expect(response).to be_successful
      expect(assigns(:projects)).to eq([ project ])
    end
  end

  describe "GET #show" do
    it "returns a success response for the project" do
      get :show, params: { id: project.id }
      expect(response).to be_successful
      expect(assigns(:project)).to eq(project)
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new project" do
        expect {
          post :create, params: { project: { title: 'New Project', description: 'Project description' } }
        }.to change(Project, :count).by(1)
        expect(response).to redirect_to(Project.last)
        expect(flash[:notice]).to eq("Project successfully created!")
      end
    end

    context "with invalid params" do
      it "re-renders the 'new' template with errors" do
        post :create, params: { project: { title: '' } }  # Invalid params
        expect(response).to render_template(:new)
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: project.id }
      expect(response).to be_successful
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      it "updates the project and redirects" do
        patch :update, params: { id: project.id, project: { title: 'Updated Title' } }
        project.reload
        expect(project.title).to eq('Updated Title')
        expect(response).to redirect_to(project)
        expect(flash[:notice]).to eq("Project successfully updated!")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the project and redirects" do
      delete :destroy, params: { id: project.id }
      expect(Project.exists?(project.id)).to be_falsey
      expect(response).to redirect_to(projects_path)
      expect(flash[:notice]).to eq("Project successfully deleted.")
    end
  end
end
