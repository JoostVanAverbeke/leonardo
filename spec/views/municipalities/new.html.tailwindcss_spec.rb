require "rails_helper"

RSpec.describe "municipalities/new", type: :view do
  before(:each) do
    assign(:municipality, Municipality.new(
      postal_code: "MyString",
      city: "MyString",
      country: "MyString"
    ))
  end

  it "renders new municipality form" do
    render

    assert_select "form[action=?][method=?]", municipalities_path, "post" do
      assert_select "input[name=?]", "municipality[postal_code]"

      assert_select "input[name=?]", "municipality[city]"

      assert_select "input[name=?]", "municipality[country]"
    end
  end
end
