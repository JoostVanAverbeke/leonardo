require 'rails_helper'

RSpec.describe "municipalities/show", type: :view do
  before(:each) do
    assign(:municipality, Municipality.create!(
      postal_code: "Postal Code",
      city: "City",
      country: "Country"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Postal Code/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Country/)
  end
end
