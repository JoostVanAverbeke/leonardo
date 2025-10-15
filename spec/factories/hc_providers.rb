FactoryBot.define do
  factory :hc_provider do
    mnemonic { Faker::Alphanumeric.alphanumeric(number: 10) }
    first_name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    birth_date { Faker::Date.birthday(min_age: 25, max_age: 78) }
    gender { %w[male female other].sample }
    address_line1 { Faker::Address.street_address }
    municipality { association :municipality }
    sequence(:email) { |n| "user#{n}@hcprovider.com" }
    phone { "+31#{Faker::Number.number(digits: 9)}" }
    mobile_phone { "+31#{Faker::Number.number(digits: 9)}" }
    internet { Faker::Internet.url(host: "hcprovider.com") }
    identifier { "#{Faker::Alphanumeric.alphanumeric(number: 5).upcase}.#{Faker::Number.number(digits: 4)}.#{Faker::Number.number(digits: 3)}" }
    title { %w[Prof Dr Nurse].sample }
  end
end
