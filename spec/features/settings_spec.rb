require 'spec_helper'

describe "Settings" do
  subject { page }

  before do
    ApplicationController.any_instance.stub(:current_user).and_return(User.first)
    visit root_path
  end

  describe "index" do
    before { click_link "Settings" }

    it { should have_selector "h3", text: "Settings" }
    it { should have_selector "th", text: "Key"}
    it { should have_selector "th", text: "Value"}
    it { should have_selector "th", text: "Protection"}

    context "if some setting has no protection" do
      before do
        (@setting = Setting.all.shuffle.first).update_column(:protected, "none")
        visit current_path
      end

      it { should have_field "setting[key]", with: @setting.key, disabled: false }
    end

    context "if some setting has key protection" do
      before do
        (@setting = Setting.all.shuffle.first).update_column(:protected, "key")
        visit current_path
      end

      it { should have_field "setting[key]", with: @setting.key, disabled: true }
    end

    context "if some setting has both fields protected" do
      before do
        (@setting = Setting.all.shuffle.first).update_column(:protected, "both")
        visit current_path
      end

      it { should have_field "setting[key]", with: @setting.key, disabled: true }
    end
  end
end
