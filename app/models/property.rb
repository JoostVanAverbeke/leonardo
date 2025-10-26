class Property < ApplicationRecord
    has_many :observations, dependent: :destroy
    validates :mnemonic, presence: true, uniqueness: true
    validates :loinc_code, presence: true, uniqueness: true
    validates :description, presence: true
    validates :data_type, presence: true
    validate :limits_ordered
    enum :data_type, { numeric: 0, string: 1, enumerated: 2 }

    def externalize
        "#{loinc_code}: #{description}"
    end

    private

    def limits_ordered
        return if low_limit.blank? || high_limit.blank?

        # Only perform the comparison if both limits are numeric
        if low_limit.to_f >= high_limit.to_f
            errors.add(:low_limit, "must be lower than high_limit")
        end
    end
end
