require 'rails_helper'

RSpec.describe "routes for Comments", type: :routing do
  let(:project_id) { "1" }
  let(:comment_id) { "1" }

  it "routes POST /projects/:project_id/comments to comments#create" do
    expect(post: "/projects/#{project_id}/comments").to route_to(
      controller: "comments",
      action: "create",
      project_id: project_id
    )
  end

  it "routes GET /projects/:project_id/comments/:id/edit to comments#edit" do
    expect(get: "/projects/#{project_id}/comments/#{comment_id}/edit").to route_to(
      controller: "comments",
      action: "edit",
      project_id: project_id,
      id: comment_id
    )
  end

  it "routes PATCH /projects/:project_id/comments/:id to comments#update" do
    expect(patch: "/projects/#{project_id}/comments/#{comment_id}").to route_to(
      controller: "comments",
      action: "update",
      project_id: project_id,
      id: comment_id
    )
  end

  it "routes DELETE /projects/:project_id/comments/:id to comments#destroy" do
    expect(delete: "/projects/#{project_id}/comments/#{comment_id}").to route_to(
      controller: "comments",
      action: "destroy",
      project_id: project_id,
      id: comment_id
    )
  end
end
