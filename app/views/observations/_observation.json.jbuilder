json.extract! observation, :id, :patient_id, :order_id, :property_id, :value, :unit, :alternate_unit, :alternate_unit_coding_system, :references_, :range, :abnormal_flags, :result_status, :observation_date_time, :analysis_date_time, :observation_comment, :created_at, :updated_at
json.url observation_url(observation, format: :json)
