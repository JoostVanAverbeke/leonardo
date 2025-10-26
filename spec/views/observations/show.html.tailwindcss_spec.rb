require 'rails_helper'

RSpec.describe "observations/show", type: :view do
  before(:each) do
    assign(:observation, Observation.create!(
      patient: nil,
      order: nil,
      property: nil,
      value: "Value",
      unit: "Unit",
      alternate_unit: "Alternate Unit",
      alternate_unit_coding_system: "Alternate Unit Coding System",
      references_: "References ",
      range: "Range",
      abnormal_flags: "Abnormal Flags",
      result_status: 2,
      observation_comment: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Value/)
    expect(rendered).to match(/Unit/)
    expect(rendered).to match(/Alternate Unit/)
    expect(rendered).to match(/Alternate Unit Coding System/)
    expect(rendered).to match(/References /)
    expect(rendered).to match(/Range/)
    expect(rendered).to match(/Abnormal Flags/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
  end
end
