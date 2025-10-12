
FactoryBot.define do
    factory :patient do
        first_name { Faker::Name.first_name }
        surname { Faker::Name.last_name }
        birth_date { Faker::Date.birthday(min_age: 0, max_age: 120) }
        gender { %w[male female other].sample }
        municipality { association :municipality }
        sequence(:email) { |n| "user#{n}@example.com" }
        phone { "+31#{Faker::Number.number(digits: 9)}" }
        mobile_phone { "+31#{Faker::Number.number(digits: 9)}" }
        internet { Faker::Internet.url(host: 'example.com') }
        sequence(:national_number) { |n| "NN#{n}#{Faker::Number.number(digits: 10)}" }
    end
end
