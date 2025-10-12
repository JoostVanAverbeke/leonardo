class Municipality < ApplicationRecord
    has_many :patients, dependent: :nullify

    validates :postal_code, presence: true
    validates :city, presence: true
    validates :country, presence: true

    def externalize
        "#{postal_code} #{city}, #{country}"
    end
end
