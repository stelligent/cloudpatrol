require 'spec_helper'

describe User do
  before do
    @random_name = -> { SecureRandom.hex }
    @valid_attributes = { name: @random_name.call, password: "password", password_confirmation: "password" }
  end

  describe "creating new" do
    context "with duplicated name" do
      it "should not be valid" do
        user = User.create(@valid_attributes)
        User.new(@valid_attributes.update({ name: user.name.upcase })).should_not be_valid
        user.delete
      end
    end

    it "creates an API token" do
      user = User.create(@valid_attributes)
      user.should be_valid
      user.api_key.length.should == 32
      user.delete
    end

    it "populates password digest" do
      user = User.create(@valid_attributes)
      user.should be_valid
      user.password_digest.should be_present
      user.delete
    end
  end
end
