class Municipality < ApplicationRecord
    has_many :patients, dependent: :nullify
    has_many :hc_providers, dependent: :nullify

    validates :postal_code, presence: true
    validates :city, presence: true
    validates :country, presence: true, format: { with: /\A[A-Z]{2}\z/, message: "must be an ISO 3166-1 alpha-2 code (2 letters)" }

    before_validation :normalize_country

    def externalize
        "#{postal_code} #{city}, #{country}"
    end

    private

    def normalize_country
        return if country.nil?
        self.country = country.to_s.strip.upcase
    end
end
