json.extract! hc_provider, :id, :mnemonic, :first_name, :surname, :birth_date, :gender, :email, :phone, :mobile_phone, :internet, :address_line1, :address_line2, :municipality_id, :identifier, :title, :created_at, :updated_at
json.url hc_provider_url(hc_provider, format: :json)
