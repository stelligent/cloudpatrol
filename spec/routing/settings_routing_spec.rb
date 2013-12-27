require "spec_helper"

puts "#{Time.now} :: settings controller tests running"

describe SettingsController do
  describe "routing" do
    it "routes to #index" do
      get("/settings").should route_to("settings#index")
    end

    it "routes to #create" do
      post("/settings").should route_to("settings#create")
    end

    it "routes to #update" do
      put("/settings/1").should route_to("settings#update", id: "1")
    end

    it "routes to #destroy" do
      delete("/settings/1").should route_to("settings#destroy", id: "1")
    end
  end
end

puts "#{Time.now} :: settings controller tests complete"
