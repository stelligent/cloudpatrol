require 'spec_helper'

describe "settings/new" do
  before(:each) do
    assign(:setting, stub_model(Setting,
      :key => "MyString",
      :value => "MyString"
    ).as_new_record)
  end

  it "renders new setting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", settings_path, "post" do
      assert_select "input#setting_key[name=?]", "setting[key]"
      assert_select "input#setting_value[name=?]", "setting[value]"
    end
  end
end
