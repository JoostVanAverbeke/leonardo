require 'rails_helper'

RSpec.describe "patients/index", type: :view do
  before(:each) do
    assign(:patients, [
      Patient.create!(
        first_name: "First Name",
        surname: "Surname",
        gender: 2,
        email: "Email",
        phone: "Phone",
        mobile_phone: "Mobile Phone",
        internet: "Internet",
        address_line1: "Address Line1",
        address_line2: "Address Line2",
        municipality: nil,
        national_number: "National Number"
      ),
      Patient.create!(
        first_name: "First Name",
        surname: "Surname",
        gender: 2,
        email: "Email",
        phone: "Phone",
        mobile_phone: "Mobile Phone",
        internet: "Internet",
        address_line1: "Address Line1",
        address_line2: "Address Line2",
        municipality: nil,
        national_number: "National Number"
      )
    ])
  end

  it "renders a list of patients" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("First Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Surname".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Email".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Phone".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Mobile Phone".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Internet".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Address Line1".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Address Line2".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("National Number".to_s), count: 2
  end
end
