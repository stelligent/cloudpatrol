require 'spec_helper'

describe "Logs" do
  subject { page }

  before do
    ApplicationController.any_instance.stub(:current_user).and_return(User.first)
    visit root_path
  end

  it { should have_link "Logs" }

  describe "index" do
    before { click_link "Logs" }

    it { should have_selector "h3", text: "Logs" }

    describe "DynamoDB is unreachable" do
      before do
        Setting.find_by_key("aws_access_key_id").update_column(:value, nil)
        Setting.find_by_key("aws_secret_access_key").update_column(:value, nil)
        Setting.find_by_key("dynamodb_log_table").update_column(:value, nil)
        visit current_path
      end

      it { should have_selector "div.alert-error", text: "Change your settings" }
      it { should_not have_selector "table" }
    end

    # Set up AWS test user for this
    # describe "DynamoDB table is active" do
    #   before do
    #     Setting.find_by_key("aws_access_key_id").update_column(:value, "text")
    #     Setting.find_by_key("aws_secret_access_key").update_column(:value, "text")
    #     visit current_path
    #   end

    #   it { should_not have_selector "div.alert-error" }
    #   it { should have_selector "table" }
    # end
  end
end
