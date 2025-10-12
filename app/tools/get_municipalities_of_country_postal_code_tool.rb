class GetMunicipalitiesOfCountryPostalCodeTool < ApplicationTool
    description <<~DESC
        This tool of the leonardo application retrieves all municipalities
        matching a given ISO 3166-1 alpha-2 country code and postal code.
        The response will include the municipalities and their attributes.
        The municipalities are ordered by country ISO 3166-1 alpha-2 code (2 letters) format and
        the municipality postal code or partial postal code.
        If there are no municipalities, it will return an empty array.
        With this tool you can get the ID of each municipality for further operations like updating or deleting.

        Expected response format:
        [
            {
                "id": 1,
                "postal_code": "8286 FC",
                "city": "Burgman aan de Rijn",
                "country": "NL"
                "created_at": "2023-10-01T12:00:00Z",
                "updated_at": "2023-10-01T12:00:00Z"
            },
            {
                "id": 2,
                "postal_code": "1812 AQ",
                "city": "Adajaendrecht",
                "country": "NL"
                "created_at": "2023-10-02T12:00:00Z",
                "updated_at": "2023-10-02T12:00:00Z"
            }
        ]
    DESC

    arguments do
        required(:country)
            .filled(:string)
            .description ("The ISO 3166-1 alpha-2 code \(2 letters\) of the country to filter municipalities by.")
        required(:postal_code)
            .filled(:string)
            .description("The postal code to filter municipalities by. This can be a full or partial postal code.")
    end

    def call(country:, postal_code:)
        municipalities = Municipality
            .where(country: country)
            .where("postal_code ILIKE ?", "%#{postal_code}%")
            .order(:country, :postal_code)
        municipalities.map do |municipality|
            {
                id: municipality.id,
                postal_code: municipality.postal_code,
                city: municipality.city,
                country: municipality.country,
                created_at: municipality.created_at.iso8601,
                updated_at: municipality.updated_at.iso8601
            }
        end
        rescue StandardError => e
            { error: e.message }
    end
end
