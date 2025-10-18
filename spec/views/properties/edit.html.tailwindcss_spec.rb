require 'rails_helper'

RSpec.describe "properties/edit", type: :view do
  let(:property) {
    Property.create!(
      mnemonic: "MyString",
      loinc_code: "MyString",
      units_of_measure: "MyString",
      low_limit: "9.99",
      high_limit: "9.99",
      data_type: 1,
      description: "MyString"
    )
  }

  before(:each) do
    assign(:property, property)
  end

  it "renders the edit property form" do
    render

    assert_select "form[action=?][method=?]", property_path(property), "post" do
      assert_select "input[name=?]", "property[mnemonic]"

      assert_select "input[name=?]", "property[loinc_code]"

      assert_select "input[name=?]", "property[units_of_measure]"

      assert_select "input[name=?]", "property[low_limit]"

      assert_select "input[name=?]", "property[high_limit]"

      assert_select "input[name=?]", "property[data_type]"

      assert_select "input[name=?]", "property[description]"
    end
  end
end
