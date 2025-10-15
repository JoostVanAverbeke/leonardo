require "rails_helper"

RSpec.describe HcProvidersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/hc_providers").to route_to("hc_providers#index")
    end

    it "routes to #new" do
      expect(get: "/hc_providers/new").to route_to("hc_providers#new")
    end

    it "routes to #show" do
      expect(get: "/hc_providers/1").to route_to("hc_providers#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/hc_providers/1/edit").to route_to("hc_providers#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/hc_providers").to route_to("hc_providers#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/hc_providers/1").to route_to("hc_providers#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/hc_providers/1").to route_to("hc_providers#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/hc_providers/1").to route_to("hc_providers#destroy", id: "1")
    end
  end
end
