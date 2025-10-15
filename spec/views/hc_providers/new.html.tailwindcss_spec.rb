require 'rails_helper'

RSpec.describe "hc_providers/new", type: :view do
  before(:each) do
    assign(:hc_provider, HcProvider.new(
      mnemonic: "MyString",
      first_name: "MyString",
      surname: "MyString",
      gender: 1,
      email: "MyString",
      phone: "MyString",
      mobile_phone: "MyString",
      internet: "MyString",
      address_line1: "MyString",
      address_line2: "MyString",
      municipality: nil,
      identifier: "MyString",
      title: "MyString"
    ))
  end

  it "renders new hc_provider form" do
    render

    assert_select "form[action=?][method=?]", hc_providers_path, "post" do
      assert_select "input[name=?]", "hc_provider[mnemonic]"

      assert_select "input[name=?]", "hc_provider[first_name]"

      assert_select "input[name=?]", "hc_provider[surname]"

      assert_select "input[name=?]", "hc_provider[gender]"

      assert_select "input[name=?]", "hc_provider[email]"

      assert_select "input[name=?]", "hc_provider[phone]"

      assert_select "input[name=?]", "hc_provider[mobile_phone]"

      assert_select "input[name=?]", "hc_provider[internet]"

      assert_select "input[name=?]", "hc_provider[address_line1]"

      assert_select "input[name=?]", "hc_provider[address_line2]"

      assert_select "input[name=?]", "hc_provider[municipality_id]"

      assert_select "input[name=?]", "hc_provider[identifier]"

      assert_select "input[name=?]", "hc_provider[title]"
    end
  end
end
