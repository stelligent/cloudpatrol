require 'spec_helper'

describe "settings/index" do
  before(:each) do
    assign(:settings, [
      stub_model(Setting,
        key: "key_1",
        value: "value_1",
        protected: "none"
      ),
      stub_model(Setting,
        key: "key_2",
        value: "value_2",
        protected: "key"
      ),
      stub_model(Setting,
        key: "key_3",
        value: "value_3",
        protected: "both"
      )
    ])
  end

  it "renders a list of settings" do
    render
    assert_select "input", value: "key_1", disabled: false
    assert_select "input", value: "value_1", disabled: false
    assert_select "input", value: "key_2", disabled: true
    assert_select "input", value: "value_2", disabled: false
    assert_select "input", value: "key_3", disabled: true
    assert_select "input", value: "value_3", disabled: true
  end
end
