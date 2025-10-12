FactoryBot.define do
    factory :municipality do
        postal_code { Faker::Address.zip_code }
        city { Faker::Address.city }
        # country { %w[BE NL FR DE GB US].sample }
        country { "NL" }
    end
end
