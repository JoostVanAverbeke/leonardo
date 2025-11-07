class GetObservationsTool < ApplicationTool
    description <<~DESC
        This tool of the leonardo application retrieves all observations matching the given criteria.
        It's useful for retrieving a list of observations.
        The response will include the observations and their attributes.
        The observations are ordered by surname and first name.
        If there are no observations, it will return an empty array.
        Matching criteria are:
        - none (first 100 observations are returned)
        - id (exact match, returns  single observation)
        - limit (maximum number of observations to retrieve)
        - order ID (exact match)
        - patient ID (exact match)
        - property ID (exact match)
        - result status range (start and end status)
        - observation date time range (start and end datetime)
        - analysis date time range (start and end datetime)
        With this tool you can get the ID of each observation for further operations
        like updating, retrieving related records or deleting.

        Expected response format:
        [
            {
                "id": 1,
                "value": "42",
                "unit: "mg/dL",
                "alternate_unit": "mmol/L",
                "alternate_unit_coding_system": "UCUM",
                "references_range": "70-110",
                "abnormal_flags": "H",
                "result_status": "final",
                "observation_date_time": "2023-10-01T12:00:00Z",
                "analysis_date_time": "2023-10-01T14:00:00Z",
                "observation_comment": "Fasting sample",
                "order": {
                    "id": 1,
                    "filler_order_number": "FO123456"
                },
                "patient": {
                    "id": 1,
                    "first_name": "John",
                    "surname": "Doe"
                },
                "property": {
                    "id": 1,
                    "mnemonic": "P1",
                    "loinc_code": "1000-0",
                    "description": "Test"
                },
                "created_at": "2023-10-01T15:00:00Z",
                "updated_at": "2023-10-01T15:00:00Z"
            },
            {
                "id": 2,
                "value": "37",
                "unit: "°C",
                "alternate_unit": null,
                "alternate_unit_coding_system": null,
                "references_range": "36.5-37.5",
                "abnormal_flags": null,
                "result_status": "initial",
                "observation_date_time": "2023-10-02T09:00:00Z",
                "analysis_date_time": null,
                "observation_comment": null,
                "order": {
                    "id": 2,
                    "filler_order_number": "FO654321"
                },
                "patient": {
                    "id": 2,
                    "first_name": "Jane",
                    "surname": "Smith"
                },
                "property": {
                    "id": 2,
                    "mnemonic": "P2",
                    "loinc_code": "8310-5",
                    "description": "Body temperature",
                },
                "created_at": "2023-10-02T10:00:00Z",
                "updated_at": "2023-10-02T10:00:00Z"
            }
        ]
    DESC
    arguments do
        optional(:id)
            .filled(:integer)
            .description("The ID of the observation to retrieve. This will return a single observation.")
        optional(:limit)
            .filled(:integer)
            .description("The maximum number of observations to retrieve. Default is 100.")
        optional(:order_id)
            .filled(:integer)
            .description("The order ID to filter observations by.")
        optional(:patient_id)
            .filled(:integer)
            .description("The patient ID to filter observations by.")
        optional(:property_id)
            .filled(:integer)
            .description("The property ID to filter observations by.")
        optional(:result_status_start)
            .filled(:string)
            .description("The start of the result status range to filter observations by.")
        optional(:result_status_end)
            .filled(:string)
            .description("The end of the result status range to filter observations by.")
        optional(:observation_date_time_start)
            .filled(:date_time)
            .description("The start of the observation date time range to filter observations by.")
        optional(:observation_date_time_end)
            .filled(:date_time)
            .description("The end of the observation date time range to filter observations by.")
        optional(:analysis_date_time_start)
            .filled(:date_time)
            .description("The start of the analysis date time range to filter observations by.")
        optional(:analysis_date_time_end)
            .filled(:date_time)
            .description("The end of the analysis date time range to filter observations by.")
    end
    def call(limit: 100, id: nil, order_id: nil, patient_id: nil, property_id: nil,
        result_status_start: nil, result_status_end: nil,
        observation_date_time_start: nil, observation_date_time_end: nil,
        analysis_date_time_start: nil, analysis_date_time_end: nil)
        observations = []
        if id
            observation = Observation.find_by(id: id)
            observations << observation if observation
        else
            observations = Observation.order(:observation_date_time).limit(limit)
            observations = observations.where(order_id: order_id) if order_id
            observations = observations.where(patient_id: patient_id) if patient_id
            observations = observations.where(property_id: property_id) if property_id
            if result_status_start && result_status_end
                observations = observations.where(result_status: result_status_start..result_status_end)
            elsif result_status_start
                observations = observations.where("result_status >= ?", result_status_start)
            elsif result_status_end
                observations = observations.where("result_status <= ?", result_status_end)
            end
            if observation_date_time_start && observation_date_time_end
                observations = observations.where(observation_date_time: observation_date_time_start..observation_date_time_end)
            elsif observation_date_time_start
                observations = observations.where("observation_date_time >= ?", observation_date_time_start)
            elsif observation_date_time_end
                observations = observations.where("observation_date_time <= ?", observation_date_time_end)
            end
            if analysis_date_time_start && analysis_date_time_end
                observations = observations.where(analysis_date_time: analysis_date_time_start..analysis_date_time_end)
            elsif analysis_date_time_start
                observations = observations.where("analysis_date_time >= ?", analysis_date_time_start)
            elsif analysis_date_time_end
                observations = observations.where("analysis_date_time <= ?", analysis_date_time_end)
            end
        end
        observations.map do |observation|
            {
                id: observation.id,
                value: observation.value,
                unit: observation.unit,
                alternate_unit: observation.alternate_unit,
                alternate_unit_coding_system: observation.alternate_unit_coding_system,
                references_range: observation.references_range,
                abnormal_flags: observation.abnormal_flags,
                result_status: observation.result_status,
                observation_date_time: observation.observation_date_time&.iso8601,
                analysis_date_time: observation.analysis_date_time&.iso8601,
                observation_comment: observation.observation_comment,
                order: observation.order ? {
                    id: observation.order.id,
                    filler_order_number: observation.order.filler_order_number
                } : nil,
                patient: observation.patient ? {
                    id: observation.patient.id,
                    first_name: observation.patient.first_name,
                    surname: observation.patient.surname
                } : nil,
                property: observation.property ? {
                    id: observation.property.id,
                    mnemonic: observation.property.mnemonic,
                    loinc_code: observation.property.loinc_code,
                    description: observation.property.description
                } : nil,
                created_at: observation.created_at.iso8601,
                updated_at: observation.updated_at.iso8601
            }
        end
        rescue StandardError => e
            { error: e.message }
    end
end
