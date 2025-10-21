json.extract! order, :id, :placer_order_number, :filler_order_number, :priority, :order_status, :patient_id, :ordering_provider_id, :relevant_clinical_information, :order_call_back_phone, :receipt_time, :created_at, :updated_at
json.url order_url(order, format: :json)
