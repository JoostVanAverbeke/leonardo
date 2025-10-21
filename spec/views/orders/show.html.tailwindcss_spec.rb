require 'rails_helper'

RSpec.describe "orders/show", type: :view do
  before(:each) do
    assign(:order, Order.create!(
      placer_order_number: "Placer Order Number",
      filler_order_number: "Filler Order Number",
      priority: 2,
      order_status: 3,
      patient: nil,
      ordering_provider: nil,
      relevant_clinical_information: "MyText",
      order_call_back_phone: "Order Call Back Phone"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Placer Order Number/)
    expect(rendered).to match(/Filler Order Number/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Order Call Back Phone/)
  end
end
