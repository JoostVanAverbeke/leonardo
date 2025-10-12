# frozen_string_literal: true

class GetMunicipalitiesTool < ApplicationTool
    description <<~DESC
        This tool of the leonardo application retrieves all municipalities.
        It's useful for retrieving a list of municipalities.
        The response will include the municipalities and their attributes.
        The municipalities are ordered by country ISO 3166-1 alpha-2 code (2 letters) and the municipality postal code.
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

    def call
        municipalities = Municipality.order(:country, :postal_code)
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
