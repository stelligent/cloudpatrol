require "spec_helper"

puts "#{Time.now} :: commmands tests running"

describe CommandsController do
  describe "routing" do
    it "routes to #index" do
      get("/commands").should route_to("commands#index")
    end

    it "routes to #perform" do
      get("/commands/test_class/test_method").should route_to("commands#perform", class: "test_class", method: "test_method")
    end
  end
end

puts "#{Time.now} :: commmands tests complete"
