require 'spec_helper'

describe Setting do
  before do
    @random_key = -> { "test_#{SecureRandom.hex}" }
    @valid_attributes = { key: @random_key.call, value: "93", protected: "key" }
  end

  let(:setting) { Setting.create(@valid_attributes) }
  subject { setting }

  it { should be_valid }
  it { should respond_to(:key) }
  it { should respond_to(:value) }
  it { should respond_to(:protected) }
  it { should respond_to(:masked) }

  describe "creating new" do
    context "without specifying key" do
      it "should not be valid" do
        Setting.new(@valid_attributes.update({ key: nil })).should_not be_valid
      end
    end

    context "with duplicated key" do
      it "should bot be valid" do
        Setting.new(@valid_attributes.update({ key: setting.key })).should_not be_valid
      end
    end

    context "with wrong protected value" do
      it "should not be valid" do
        Setting.new(@valid_attributes.update({ protected: SecureRandom.hex })).should_not be_valid
      end
    end

    it "returns value as string" do
      value = 93
      setting = Setting.create(@valid_attributes.update({ value: value }))
      setting.should be_valid
      setting.reload
      setting.value.class.should == String
      setting.value.should == "93"
      setting.delete
    end

    it "beautifies the key" do
      key = "*** Testing Th&%^is *kiNd of_k#ey "
      setting = Setting.create(@valid_attributes.update({ key: key }))
      setting.should be_valid
      setting.key.should == "testing_this_kind_of_key"
      setting.delete
    end

    it "ensures protection" do
      setting = Setting.create(@valid_attributes.update({ protected: nil }))
      setting.should be_valid
      setting.protected.should == "key"
      setting.delete
    end
  end

  describe "#key_protected?" do
    before { @setting = Setting.create(@valid_attributes) }

    context "when protected == key" do
      before { @setting.update_column :protected, "key" }

      it "should be valid" do
        @setting.should be_valid
      end

      it "returns true" do
        @setting.key_protected?.should be_true
      end
    end

    context "when protected == both" do
      before { @setting.update_column :protected, "both" }

      it "should be valid" do
        @setting.should be_valid
      end

      it "returns true" do
        @setting.key_protected?.should be_true
      end
    end

    context "when protected == none" do
      before { @setting.update_column :protected, "none" }

      it "should be valid" do
        @setting.should be_valid
      end

      it "returns false" do
        @setting.key_protected?.should be_false
      end
    end
  end

  describe "#value_protected?" do
    before { @setting = Setting.create(@valid_attributes) }

    context "when protected == key" do
      before { @setting.update_column :protected, "key" }

      it "should be valid" do
        @setting.should be_valid
      end

      it "returns false" do
        @setting.value_protected?.should be_false
      end
    end

    context "when protected == both" do
      before { @setting.update_column :protected, "both" }

      it "should be valid" do
        @setting.should be_valid
      end

      it "returns true" do
        @setting.value_protected?.should be_true
      end
    end

    context "when protected == none" do
      before { @setting.update_column :protected, "none" }

      it "should be valid" do
        @setting.should be_valid
      end

      it "returns false" do
        @setting.value_protected?.should be_false
      end
    end
  end
end
