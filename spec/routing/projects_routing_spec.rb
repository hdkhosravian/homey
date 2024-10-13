require 'rails_helper'

RSpec.describe "routes for Projects", type: :routing do
  it "routes /projects to the projects#index" do
    expect(get: "/projects").to route_to("projects#index")
  end

  it "routes /projects/new to the projects#new" do
    expect(get: "/projects/new").to route_to("projects#new")
  end

  it "routes POST /projects to the projects#create" do
    expect(post: "/projects").to route_to("projects#create")
  end

  it "routes /projects/:id to the projects#show" do
    expect(get: "/projects/1").to route_to("projects#show", id: "1")
  end

  it "routes /projects/:id/edit to the projects#edit" do
    expect(get: "/projects/1/edit").to route_to("projects#edit", id: "1")
  end

  it "routes PATCH /projects/:id to the projects#update" do
    expect(patch: "/projects/1").to route_to("projects#update", id: "1")
  end

  it "routes DELETE /projects/:id to the projects#destroy" do
    expect(delete: "/projects/1").to route_to("projects#destroy", id: "1")
  end
end
