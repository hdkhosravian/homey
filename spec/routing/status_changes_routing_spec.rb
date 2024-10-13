require 'rails_helper'

RSpec.describe "routes for StatusChanges", type: :routing do
  it "routes GET /projects/:project_id/status_change/edit to status_changes#edit" do
    expect(get: "/projects/1/status_change/edit").to route_to(
      controller: "status_changes",
      action: "edit",
      project_id: "1"
    )
  end

  it "routes PATCH /projects/:project_id/status_change to status_changes#update" do
    expect(patch: "/projects/1/status_change").to route_to(
      controller: "status_changes",
      action: "update",
      project_id: "1"
    )
  end
end
