require 'spec_helper'

describe "settings/index" do
  before(:each) do
    assign(:settings, [
      stub_model(Setting,
        key: "key_1",
        value: "value"
      ),
      stub_model(Setting,
        key: "key_2",
        value: "value"
      )
    ])
  end

  it "renders a list of settings" do
    render
    assert_select "input", text: "key_1".to_s
    assert_select "input", text: "key_2".to_s
    assert_select "input", text: "value".to_s, count: 2
  end
end
