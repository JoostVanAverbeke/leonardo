require_relative "../stores/loinc_store"

FactoryBot.define do
  factory :property do
    data_type { "numeric" }
    transient do
      loinc_code { LoincStore.chemistry_codes.sample }
      mean_value { Faker::Number.between(from: 10.0, to: 100.0).round(2) }
    end

    after(:build) do |property, evaluator|
      property.mnemonic = evaluator.loinc_code.loinc_num
      property.loinc_code = evaluator.loinc_code.loinc_num
      property.description = evaluator.loinc_code.shortname
      property.units_of_measure = evaluator.loinc_code.example_ucum_units
      property.low_limit = (evaluator.mean_value * 0.6).round(2)
      property.high_limit = (evaluator.mean_value * 1.4).round(2)
    end
  end
end
