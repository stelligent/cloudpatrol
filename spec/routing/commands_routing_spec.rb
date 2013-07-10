require "spec_helper"

describe CommandsController do
  describe "routing" do
    it "routes to #index" do
      get("/commands").should route_to("commands#index")
    end

    it "routes to #perform" do
      get("/commands/perform").should route_to("commands#perform")
    end
  end
end
