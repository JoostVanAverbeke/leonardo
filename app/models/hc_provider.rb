class HcProvider < ApplicationRecord
  belongs_to :municipality

  validates :mnemonic, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :surname, presence: true
  validates :identifier, uniqueness: true, allow_blank: true
  validates :email, allow_blank: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :phone, allow_blank: true, format: { with: /\A\+?[0-9\s\-]+\z/ }
  validates :mobile_phone, allow_blank: true, format: { with: /\A\+?[0-9\s\-]+\z/ }
  validates :internet, allow_blank: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }

  enum :gender, { male: 0, female: 1, other: 2 }
end
