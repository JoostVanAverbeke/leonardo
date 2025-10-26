FactoryBot.define do
  factory :observation do
    patient { association :patient }
    order { association :order }
    property { association :property }
    value { Faker::Number.decimal(l_digits: 3, r_digits: 3).to_s }
    unit { %w[ mg/dL mmol/L g/L IU/L ].sample }
    alternate_unit { %w[ mg/dL mmol/L g/L IU/L ].sample }
    alternate_unit_coding_system { "http://unitsofmeasure.org" }
    references_range { "MyString" }
    abnormal_flags { %w[ N L H LL HH A AA ].sample }
    result_status {
      %w[ initial expected available confirmed validated corrected cancelled entered_in_error ].sample
    }
    observation_date_time { Faker::Time.between(from: 2.days.ago, to: DateTime.now) }
    analysis_date_time { Faker::Time.between(from: 2.days.ago, to: DateTime.now) }
    observation_comment { Faker::Lorem.sentence(word_count: 15) }
  end
end
