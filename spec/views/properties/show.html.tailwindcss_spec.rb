require 'rails_helper'

RSpec.describe "properties/show", type: :view do
  before(:each) do
    assign(:property, Property.create!(
      mnemonic: "Mnemonic",
      loinc_code: "Loinc Code",
      units_of_measure: "Units Of Measure",
      low_limit: "9.99",
      high_limit: "9.99",
      data_type: 2,
      description: "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Mnemonic/)
    expect(rendered).to match(/Loinc Code/)
    expect(rendered).to match(/Units Of Measure/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Description/)
  end
end
