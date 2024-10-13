require 'rails_helper'

RSpec.describe "routes for Notifications", type: :routing do
  let(:project_id) { "1" }

  it "routes GET /projects/:project_id/notifications to notifications#index" do
    expect(get: "/projects/#{project_id}/notifications").to route_to(
      controller: "notifications",
      action: "index",
      project_id: project_id
    )
  end
end
