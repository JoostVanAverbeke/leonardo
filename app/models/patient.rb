class Patient < ApplicationRecord
  belongs_to :municipality
  has_many :orders, dependent: :destroy
  has_many :observations, dependent: :destroy

  validates :first_name, presence: true
  validates :surname, presence: true
  validates :birth_date, presence: true
  validates :gender, presence: true
  validates :national_number, uniqueness: true, allow_blank: true
  validates :email, allow_blank: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :phone, allow_blank: true, format: { with: /\A\+?[0-9\s\-]+\z/ }
  validates :mobile_phone, allow_blank: true, format: { with: /\A\+?[0-9\s\-]+\z/ }
  validates :internet, allow_blank: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }

  enum :gender, { male: 0, female: 1, other: 2 }

  def externalize
    "#{surname} #{first_name}, #{birth_date}"
  end
end
