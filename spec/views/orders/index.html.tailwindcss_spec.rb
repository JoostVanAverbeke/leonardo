require 'rails_helper'

RSpec.describe "orders/index", type: :view do
  before(:each) do
    assign(:orders, [
      Order.create!(
        placer_order_number: "Placer Order Number",
        filler_order_number: "Filler Order Number",
        priority: 2,
        order_status: 3,
        patient: nil,
        ordering_provider: nil,
        relevant_clinical_information: "MyText",
        order_call_back_phone: "Order Call Back Phone"
      ),
      Order.create!(
        placer_order_number: "Placer Order Number",
        filler_order_number: "Filler Order Number",
        priority: 2,
        order_status: 3,
        patient: nil,
        ordering_provider: nil,
        relevant_clinical_information: "MyText",
        order_call_back_phone: "Order Call Back Phone"
      )
    ])
  end

  it "renders a list of orders" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Placer Order Number".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Filler Order Number".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Order Call Back Phone".to_s), count: 2
  end
end
