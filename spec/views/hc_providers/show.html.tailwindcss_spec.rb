require 'rails_helper'

RSpec.describe "hc_providers/show", type: :view do
  before(:each) do
    assign(:hc_provider, HcProvider.create!(
      mnemonic: "Mnemonic",
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
      identifier: "Identifier",
      title: "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Mnemonic/)
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Surname/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Mobile Phone/)
    expect(rendered).to match(/Internet/)
    expect(rendered).to match(/Address Line1/)
    expect(rendered).to match(/Address Line2/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Identifier/)
    expect(rendered).to match(/Title/)
  end
end
