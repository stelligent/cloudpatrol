require 'spec_helper'

describe "Commands" do
  subject { page }

  before do
    ApplicationController.any_instance.stub(:current_user).and_return(User.first)
    visit root_path
  end

  it { should have_link "Commands" }

  describe "index" do
    before { click_link "Commands" }

    it { should have_title "Commands | CloudPatrol" }
    it { should have_selector "h3", text: "Commands" }
    it { should have_selector "th", text: "EC2" }
    it { should have_selector "th", text: "IAM" }
    it { should have_selector "th", text: "OpsWorks" }
    it { should have_selector "th", text: "CloudFormation" }

    context "if AWS credentials are missing" do
      before do
        Setting.find_by_key("aws_access_key_id").update_column(:value, nil)
        Setting.find_by_key("aws_secret_access_key").update_column(:value, nil)
        visit current_path
      end

      it { should have_selector "div.alert-error", text: "AWS credentials are missing! Instance profiles may apply." }
      # it { should_not have_link "perform" }
    end

    context "if there are AWS credentials" do
      before do
        Setting.find_by_key("aws_access_key_id").update_column(:value, "text")
        Setting.find_by_key("aws_secret_access_key").update_column(:value, "text")
        visit current_path
      end

      it { should_not have_selector "div.alert-error", text: "AWS credentials are missing! Instance profiles may apply." }
      it { should have_link "perform" }

      # TODO: Test this whole thing

      # describe "trying to perform a command" do
      #   before { click_link "perform", match: :first }

      #   it { should have_selector "div.alert" }
      # end
    end
  end
end
