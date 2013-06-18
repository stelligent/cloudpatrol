require 'spec_helper'

describe "Login" do
  subject { page }

  before { visit root_path }

  it { should have_link "Log in", href: login_path }

  describe "page" do
    before { click_link "Log in" }

    it { should have_title "CloudPatrol | Log in" }
    it { should have_selector "h3", text: "Log in" }
    it { should have_field "name" }
    it { should have_field "password" }

    describe "attempt with valid params" do
      pending
    end

    describe "attempt with invalid params" do
      before { click_button "Log in" }

      it { should have_selector "div.alert", "Invalid credentials" }
    end
  end
end
