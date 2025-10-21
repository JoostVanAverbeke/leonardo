class Order < ApplicationRecord
  belongs_to :patient
  belongs_to :hc_provider, foreign_key: :ordering_provider_id

  validates :filler_order_number, presence: true, uniqueness: true
  validates :order_call_back_phone, allow_blank: true, format: { with: /\A\+?[0-9\s\-]+\z/ }
  validates :receipt_time, presence: true

  enum :priority, { routine: 0, urgent: 1, stat: 2 }
  enum :order_status, { new_order: 0, in_progress: 1, completed: 2, cancelled: 3 }

  def ordering_provider
    HcProvider.find(ordering_provider_id)
  end
end
