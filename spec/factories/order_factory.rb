FactoryBot.define do
  factory :order do
    placer_order_number { Faker::Number.number(digits: 10) }
    filler_order_number { "#{Faker::Date.between(from: 5.days.ago, to: Date.today).strftime('%Y%m%d')}-#{Faker::Number.number(digits: 8)}" }
    priority { %w[ routine urgent stat ].sample }
    order_status { %w[ new_order in_progress completed cancelled ].sample }
    patient { association :patient }
    ordering_provider { association :hc_provider }
    relevant_clinical_information { Faker::Lorem.sentence(word_count: 10) }
    order_call_back_phone { "+31#{Faker::Number.number(digits: 9)}" }
    receipt_time { Faker::Time.between(from: 2.days.ago, to: DateTime.now) }
  end
end
