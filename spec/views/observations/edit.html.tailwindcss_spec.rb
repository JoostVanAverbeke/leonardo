require 'rails_helper'

RSpec.describe "observations/edit", type: :view do
  let(:observation) {
    Observation.create!(
      patient: nil,
      order: nil,
      property: nil,
      value: "MyString",
      unit: "MyString",
      alternate_unit: "MyString",
      alternate_unit_coding_system: "MyString",
      references_: "MyString",
      range: "MyString",
      abnormal_flags: "MyString",
      result_status: 1,
      observation_comment: "MyText"
    )
  }

  before(:each) do
    assign(:observation, observation)
  end

  it "renders the edit observation form" do
    render

    assert_select "form[action=?][method=?]", observation_path(observation), "post" do
      assert_select "input[name=?]", "observation[patient_id]"

      assert_select "input[name=?]", "observation[order_id]"

      assert_select "input[name=?]", "observation[property_id]"

      assert_select "input[name=?]", "observation[value]"

      assert_select "input[name=?]", "observation[unit]"

      assert_select "input[name=?]", "observation[alternate_unit]"

      assert_select "input[name=?]", "observation[alternate_unit_coding_system]"

      assert_select "input[name=?]", "observation[references_]"

      assert_select "input[name=?]", "observation[range]"

      assert_select "input[name=?]", "observation[abnormal_flags]"

      assert_select "input[name=?]", "observation[result_status]"

      assert_select "textarea[name=?]", "observation[observation_comment]"
    end
  end
end
