class Patient < ApplicationRecord
  belongs_to :municipality
  validates :first_name, presence: true
  validates :surname, presence: true
  validates :birth_date, presence: true
  validates :gender, presence: true

  enum :gender, { male: 0, female: 1, other: 2 }
end
