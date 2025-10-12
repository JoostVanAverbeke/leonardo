require "rails_helper"

RSpec.describe "patients/new", type: :view do
  before(:each) do
    assign(:patient, Patient.new(
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
      national_number: "MyString"
    ))
  end

  it "renders new patient form" do
    render

    assert_select "form[action=?][method=?]", patients_path, "post" do
      assert_select "input[name=?]", "patient[first_name]"

      assert_select "input[name=?]", "patient[surname]"

      assert_select "input[name=?]", "patient[gender]"

      assert_select "input[name=?]", "patient[email]"

      assert_select "input[name=?]", "patient[phone]"

      assert_select "input[name=?]", "patient[mobile_phone]"

      assert_select "input[name=?]", "patient[internet]"

      assert_select "input[name=?]", "patient[address_line1]"

      assert_select "input[name=?]", "patient[address_line2]"

      assert_select "input[name=?]", "patient[municipality_id]"

      assert_select "input[name=?]", "patient[national_number]"
    end
  end
end
