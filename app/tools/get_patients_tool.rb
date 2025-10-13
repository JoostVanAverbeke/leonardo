# frozen_string_literal: true

class GetPatientsTool < ApplicationTool
    description <<~DESC
        This tool of the leonardo application retrieves all patients matching the given criteria.
        It's useful for retrieving a list of patients.
        The response will include the patients and their attributes.
        The patients are ordered by surname and first name.
        If there are no patients, it will return an empty array.
        Matching criteria are:
        - none (all patients are returned)
        - surname and/or first name (partial matches allowed)
        - birth date (exact match)
        - national number (exact match)
        - email (exact match)
        - municipality ID (exact match)
        With this tool you can get the ID of each patient for further operations
        like updating, retrieving related records or deleting.

        Expected response format:
        [
            {
                "id": 1,
                "first_name": "John",
                "surname": "Doe",
                "birth_date": "1980-01-01",
                "national_number": "123456789",
                "email": "John.Smith@leonardo.com",
                "phone": "+1234567890",
                "mobile_phone": "+1987654321",
                "internet": "http://johndoe.com",
                "gender": "male",
                "address_line1": "456 Elm St",
                "address_line2": "Suite 5A",
                "municipality_id": 1,
                "created_at": "2023-10-01T12:00:00Z",
                "updated_at": "2023-10-01T12:00:00Z"
            },
            {
                "id": 2,
                "first_name": "Jane",
                "surname": "Smith",
                "birth_date": "1990-02-02",
                "national_number": "987654321",
                "email": "Jane.Smith@leonardo.com",
                "phone": "+1098765432",
                "mobile_phone": "+1234567890",
                "internet": "http://janesmith.com",
                "gender": "female",
                "address_line1": "123 Main St",
                "address_line2": "Apt 4B",
                "municipality_id": 2,
                "created_at": "2023-10-02T12:00:00Z",
                "updated_at": "2023-10-02T12:00:00Z"
            }
        ]
    DESC

    arguments do
        optional(:surname).filled(:string).description("The surname to filter patients by. Partial matches are allowed.")
        optional(:first_name).filled(:string).description("The first name to filter patients by. Partial matches are allowed.")
        optional(:birth_date).filled(:date).description("The birth date to filter patients by. Exact match only.")
        optional(:national_number).filled(:string).description("The national number to filter patients by. Exact match only.")
        optional(:email).filled(:string).description("The email to filter patients by. Exact match only.")
        optional(:municipality_id).filled(:integer).description("The municipality ID to filter patients by. Exact match only.")
    end

    def call(surname: nil, first_name: nil, birth_date: nil, national_number: nil, email: nil, municipality_id: nil)
        patients = Patient.order(:surname, :first_name)
        patients = patients.where("surname ILIKE ?", "%#{surname}%") if surname
        patients = patients.where("first_name ILIKE ?", "%#{first_name}%") if first_name
        patients = patients.where(birth_date: birth_date) if birth_date
        patients = patients.where(national_number: national_number) if national_number
        patients = patients.where(email: email) if email
        patients = patients.where(municipality_id: municipality_id) if municipality_id
        patients.map do |patient|
            {
                id: patient.id,
                first_name: patient.first_name,
                surname: patient.surname,
                birth_date: patient.birth_date.iso8601,
                national_number: patient.national_number,
                email: patient.email,
                phone: patient.phone,
                mobile_phone: patient.mobile_phone,
                internet: patient.internet,
                gender: patient.gender,
                address_line1: patient.address_line1,
                address_line2: patient.address_line2,
                municipality_id: patient.municipality_id,
                created_at: patient.created_at.iso8601,
                updated_at: patient.updated_at.iso8601
            }
        end
        rescue StandardError => e
            { error: e.message }
    end
end
