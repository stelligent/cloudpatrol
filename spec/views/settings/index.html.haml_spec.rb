require 'spec_helper'

describe "settings/index" do
  before(:each) do
    assign(:settings, [
      stub_model(Setting,
        key: "key_1",
        value: "value",
        protected: false
      ),
      stub_model(Setting,
        key: "key_2",
        value: "value",
        protected: true
      )
    ])
  end

  it "renders a list of settings" do
    render
    assert_select "input", value: "key_1"
    assert_select "input", value: "key_2", disabled: true
    assert_select "input", value: "value"
    assert_select "input", value: "value", disabled: true
  end
end
