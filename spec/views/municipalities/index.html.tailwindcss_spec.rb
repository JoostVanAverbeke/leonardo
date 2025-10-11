require 'rails_helper'

RSpec.describe "municipalities/index", type: :view do
  before(:each) do
    assign(:municipalities, [
      Municipality.create!(
        postal_code: "Postal Code",
        city: "City",
        country: "Country"
      ),
      Municipality.create!(
        postal_code: "Postal Code",
        city: "City",
        country: "Country"
      )
    ])
  end

  it "renders a list of municipalities" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Postal Code".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("City".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Country".to_s), count: 2
  end
end
