require "rails_helper"

RSpec.describe AutorizadosController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/autorizados").to route_to("autorizados#index")
    end

    it "routes to #new" do
      expect(get: "/autorizados/new").to route_to("autorizados#new")
    end

    it "routes to #show" do
      expect(get: "/autorizados/1").to route_to("autorizados#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/autorizados/1/edit").to route_to("autorizados#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/autorizados").to route_to("autorizados#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/autorizados/1").to route_to("autorizados#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/autorizados/1").to route_to("autorizados#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/autorizados/1").to route_to("autorizados#destroy", id: "1")
    end
  end
end
