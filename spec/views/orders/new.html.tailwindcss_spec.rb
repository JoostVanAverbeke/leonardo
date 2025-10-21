require 'rails_helper'

RSpec.describe "orders/new", type: :view do
  before(:each) do
    assign(:order, Order.new(
      placer_order_number: "MyString",
      filler_order_number: "MyString",
      priority: 1,
      order_status: 1,
      patient: nil,
      ordering_provider: nil,
      relevant_clinical_information: "MyText",
      order_call_back_phone: "MyString"
    ))
  end

  it "renders new order form" do
    render

    assert_select "form[action=?][method=?]", orders_path, "post" do
      assert_select "input[name=?]", "order[placer_order_number]"

      assert_select "input[name=?]", "order[filler_order_number]"

      assert_select "input[name=?]", "order[priority]"

      assert_select "input[name=?]", "order[order_status]"

      assert_select "input[name=?]", "order[patient_id]"

      assert_select "input[name=?]", "order[ordering_provider_id]"

      assert_select "textarea[name=?]", "order[relevant_clinical_information]"

      assert_select "input[name=?]", "order[order_call_back_phone]"
    end
  end
end
