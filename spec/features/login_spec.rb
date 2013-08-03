require 'spec_helper'

describe "Login" do
  subject { page }

  before { visit root_path }

  it { should have_link "Log in", href: login_path }

  describe "page" do
    before { click_link "Log in" }

    it { should have_title "Log in | CloudPatrol" }
    it { should have_selector "h3", text: "Log in" }
    it { should have_field "name" }
    it { should have_field "password" }

    describe "attempt with valid params" do
      before do
        fill_in "name", with: "admin"
        fill_in "password", with: "admin"
        click_button "Log in"
      end

      # Menu for logged in
      it { should have_link "Commands", href: commands_path }
      it { should have_link "Logs", href: logs_path }
      it { should have_link "Settings", href: settings_path }
      it { should have_link "Help", href: help_path }
      it { should have_link "Profile", href: profile_path }
      it { should have_link "Log out", href: logout_path }

      describe "help page" do
        before { click_link "Help" }

        it { should have_title "Help | CloudPatrol" }
        it { should have_selector "h3", text: "Help" }
      end
    end

    describe "attempt with invalid params" do
      before { click_button "Log in" }

      it { should have_selector "div.alert", "Invalid credentials" }

      # Menu for not logged in
      it { should have_link "Log in" }
    end
  end
end
