# spec/routing/home_routing_spec.rb

require "rails_helper"

RSpec.describe HomeController, type: :routing do
  describe "routing" do
    it "routes root path to home#index" do
      expect(get: "/").to route_to("home#index")
    end
  end
end
