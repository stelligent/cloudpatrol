require 'spec_helper'

describe "Settings" do
  describe "GET /settings" do
    it "works! (now write some real specs)" do
      get settings_path
      response.status.should be(200)
    end
  end
end
