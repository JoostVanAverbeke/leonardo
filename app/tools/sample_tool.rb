# frozen_string_literal: true

class SampleTool < ApplicationTool
  description "Greet a patient by their first name, surname."

  # Optional: Add annotations to provide hints about the tool's behavior
  # annotations(
  #   title: "User Greeting",
  #   read_only_hint: true,      # This tool only reads data
  #   open_world_hint: false     # This tool only accesses the local database
  # )

  arguments do
    required(:id).filled(:integer).description("ID of the user to greet")
    optional(:prefix).filled(:string).description("Prefix to add to the greeting")
  end

  def call(id:, prefix: "Hey")
    patient = Patient.find(id)

    "#{prefix} #{patient.first_name} #{patient.surname} !"
  end
end
