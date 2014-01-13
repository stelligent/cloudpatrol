require 'spec_helper'

describe User do
  before do
    @random_name = -> { SecureRandom.hex }
    @valid_attributes = { name: @random_name.call, password: "password", password_confirmation: "password" }
  end

  let(:user) { User.create(@valid_attributes) }
  subject { user }

  it { should be_valid }
  it { should respond_to(:name) }
  it { should respond_to(:api_key) }

  describe "creating new" do
    context "with duplicated name" do
      it "should not be valid" do
        User.new(@valid_attributes.update({ name: user.name.upcase })).should_not be_valid
      end
    end

    it "creates an API token" do
      user.api_key.length.should == 32
    end

    it "populates password digest" do
      user.password_digest.should be_present
    end
  end
end
