class GetHcProvidersTool < ApplicationTool
    description <<~DESC
        This tool of the leonardo application retrieves all healthcare providers matching the given criteria.
        It's useful for retrieving a list of healthcare providers.
        The response will include the healthcare providers and their attributes.
        The healthcare providers are ordered by surname and first name.
        If there are no healthcare providers, it will return an empty array.
        Matching criteria are:
        - none (first 100 healthcare providers are returned)
        - id (exact match, returns single healthcare provider)
        - limit (maximum number of healthcare providers to retrieve)
        - mnemonic (partial matches allowed)
        - first name (partial matches allowed)
        - surname (partial matches allowed)
        - birth date (exact match)
        - identifier (exact match)
        - email (exact match)
        - municipality ID (exact match)
        With this tool you can get the ID of each healthcare provider for further operations
        like updating, retrieving related records or deleting.

        Expected response format:
        [
            {
                "id": 1,
                "mnemonic": "DRSMITH",
                "first_name": "John",
                "surname": "Smith",
                "birth_date": "1975-05-20",
                "identifier": "HC123456",
                "gender": "male",
                "email": "john.smith@example.com",
                "phone": "+1234567890",
                "mobile_phone": "+1987654321",
                "internet": "http://drjohnsmith.com",
                "address_line1": "789 Oak St",
                "address_line2": "Floor 2",
                "municipality": {
                    "id": 3,
                    "postal_code": "3000",
                    "city": "Antwerp",
                    "country": "BE"
                },
                "title": "MD",
                "created_at": "2023-10-01T12:00:00Z",
                "updated_at": "2023-10-01T12:00:00Z"
            },
            {
                "id": 2,
                "mnemonic": "DRJONES",
                "first_name": "Emily",
                "surname": "Jones",
                "birth_date": "1980-08-15",
                "gender": "female",
                "identifier": "HC654321",
                "email": "emily.jones@example.com",
                "phone": "+1098765432",
                "mobile_phone": "+1234567890",
                "internet": "http://dremilyjones.com",

                "address_line1": "321 Pine St",
                "address_line2": "Apt 7C",
                "municipality": {
                    "id": 4,
                    "postal_code": "4000",
                    "city": "Liège",
                    "country": "BE"
                },
                "title": "DO",
                "created_at": "2023-10-02T12:00:00Z",
                "updated_at": "2023-10-02T12:00:00Z"
            }
        ]
    DESC

    arguments do
        optional(:id)
            .filled(:integer)
            .description("The ID of the healthcare provider to retrieve. This will return a single healthcare provider.")
        optional(:limit)
            .filled(:integer)
            .description("The maximum number of healthcare providers to retrieve. Default is 100.")
        optional(:mnemonic)
            .filled(:string)
            .description("The mnemonic to filter healthcare providers by. This can be a full or partial mnemonic.")
        optional(:first_name)
            .filled(:string)
            .description("The first name to filter healthcare providers by. This can be a full or partial first name.")
        optional(:surname)
            .filled(:string)
            .description("The surname to filter healthcare providers by. This can be a full or partial surname.")
        optional(:birth_date)
            .filled(:date)
            .description("The birth date to filter healthcare providers by. This must be an exact match.")
        optional(:identifier)
            .filled(:string)
            .description("The identifier to filter healthcare providers by. This must be an exact match.")
        optional(:email)
            .filled(:string)
            .description("The email to filter healthcare providers by. This must be an exact match.")
        optional(:municipality_id)
            .filled(:integer)
            .description("The municipality ID to filter healthcare providers by. This must be an exact match.")
    end

    def call(limit: 100, id: nil, mnemonic: nil, first_name: nil, surname: nil, birth_date: nil,
            identifier: nil, email: nil, municipality_id: nil)
        hc_providers = []
        if id
            hc_provider = HcProvider.find_by(id: id)
            hc_providers << hc_provider if hc_provider
        else
            hc_providers = HcProvider.order(:surname, :first_name).limit(limit)
            hc_providers = hc_providers.where("mnemonic ILIKE ?", "%#{mnemonic}%") if mnemonic
            hc_providers = hc_providers.where("first_name ILIKE ?", "%#{first_name}%") if first_name
            hc_providers = hc_providers.where("surname ILIKE ?", "%#{surname}%") if surname
            hc_providers = hc_providers.where(birth_date: birth_date) if birth_date
            hc_providers = hc_providers.where(identifier: identifier) if identifier
            hc_providers = hc_providers.where(email: email) if email
            hc_providers = hc_providers.where(municipality_id: municipality_id) if municipality_id
        end
        hc_providers.map do |hc_provider|
            {
                id: hc_provider.id,
                mnemonic: hc_provider.mnemonic,
                first_name: hc_provider.first_name,
                surname: hc_provider.surname,
                birth_date: hc_provider.birth_date&.iso8601,
                gender: hc_provider.gender,
                identifier: hc_provider.identifier,
                email: hc_provider.email,
                phone: hc_provider.phone,
                mobile_phone: hc_provider.mobile_phone,
                internet: hc_provider.internet,
                address_line1: hc_provider.address_line1,
                address_line2: hc_provider.address_line2,
                municipality: {
                    id: hc_provider.municipality.id,
                    postal_code: hc_provider.municipality.postal_code,
                    city: hc_provider.municipality.city,
                    country: hc_provider.municipality.country
                },
                title: hc_provider.title,
                created_at: hc_provider.created_at.iso8601,
                updated_at: hc_provider.updated_at.iso8601
            }
        end
        rescue StandardError => e
            { error: e.message }
    end
end
