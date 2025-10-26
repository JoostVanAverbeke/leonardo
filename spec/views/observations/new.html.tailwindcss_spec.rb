require 'rails_helper'

RSpec.describe "observations/new", type: :view do
  before(:each) do
    assign(:observation, Observation.new(
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
    ))
  end

  it "renders new observation form" do
    render

    assert_select "form[action=?][method=?]", observations_path, "post" do
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
