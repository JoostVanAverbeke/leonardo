require "rails_helper"

RSpec.describe "municipalities/edit", type: :view do
  let(:municipality) {
    Municipality.create!(
      postal_code: "MyString",
      city: "MyString",
      country: "MyString"
    )
  }

  before(:each) do
    assign(:municipality, municipality)
  end

  it "renders the edit municipality form" do
    render

    assert_select "form[action=?][method=?]", municipality_path(municipality), "post" do
      assert_select "input[name=?]", "municipality[postal_code]"

      assert_select "input[name=?]", "municipality[city]"

      assert_select "input[name=?]", "municipality[country]"
    end
  end
end
