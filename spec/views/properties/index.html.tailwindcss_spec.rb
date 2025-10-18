require 'rails_helper'

RSpec.describe "properties/index", type: :view do
  before(:each) do
    assign(:properties, [
      Property.create!(
        mnemonic: "Mnemonic",
        loinc_code: "Loinc Code",
        units_of_measure: "Units Of Measure",
        low_limit: "9.99",
        high_limit: "9.99",
        data_type: 2,
        description: "Description"
      ),
      Property.create!(
        mnemonic: "Mnemonic",
        loinc_code: "Loinc Code",
        units_of_measure: "Units Of Measure",
        low_limit: "9.99",
        high_limit: "9.99",
        data_type: 2,
        description: "Description"
      )
    ])
  end

  it "renders a list of properties" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Mnemonic".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Loinc Code".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Units Of Measure".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Description".to_s), count: 2
  end
end
