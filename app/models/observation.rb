class Observation < ApplicationRecord
  belongs_to :patient
  belongs_to :order
  belongs_to :property
  validates :value, presence: true
  validates :order_id, presence: true
  validates :patient_id, presence: true
  validates :property_id, presence: true
  validates :observation_date_time, presence: true
  validates :result_status, presence: true

  enum :result_status, {
    initial: 0,
    expected: 1,
    available: 2,
    confirmed: 3,
    validated: 4,
    corrected: 5,
    cancelled: 6,
    entered_in_error: 7
  }

  before_validation :ensure_patient_id_has_value, on: :create

  private

  def ensure_patient_id_has_value
    self.patient_id ||= order.patient_id if order.present?
  end
end
