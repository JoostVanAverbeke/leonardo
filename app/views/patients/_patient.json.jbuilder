json.extract! patient, :id, :first_name, :surname, :birth_date, :gender, :email, :phone, :mobile_phone, :internet, :address_line1, :address_line2, :municipality_id, :national_number, :created_at, :updated_at
json.url patient_url(patient, format: :json)
