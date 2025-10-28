class GetPropertiesTool < ApplicationTool
  description <<~DESC
        This tool of the leonardo application retrieves all properties matching the given criteria.
        It's useful for retrieving a list of properties.
        The response will include the properties and their attributes.
        The properties are ordered by loinc code.
        If there are no properties, it will return an empty array.
        Matching criteria are:
        - none (first 100 properties are returned)
        - id (exact match, returns single property)
        - limit (maximum number of properties to retrieve)
        - loinc code (exact match)
        - mnemonic (partial matches allowed)
        - description (partial matches allowed)
        With this tool you can get the ID of each property for further operations
        like updating, retrieving related records or deleting.

        Expected response format:
        [
            {
                "id": 1,
                "mnemonic": "GLU",
                "loinc_code": "2345-7",
                "units_of_measure": "mg/dL",
                "low_limit": 70.0,
                "high_limit": 110.0,
                "data_type": "decimal",
                "description": "Glucose [Mass/volume] in Blood",
                "created_at": "2023-10-01T12:00:00Z",
                "updated_at": "2023-10-01T12:00:00Z"
            },
            {
                "id": 2,
                "mnemonic": "HGB",
                "loinc_code": "718-7",
                "units_of_measure": "g/dL",
                "low_limit": 12.0,
                "high_limit": 16.0,
                "data_type": "decimal",
                "description": "Hemoglobin [Mass/volume] in Blood",
                "created_at": "2023-10-02T12:00:00Z",
                "updated_at": "2023-10-02T12:00:00Z"
            }
        ]
    DESC

  arguments do
    optional(:id)
      .filled(:integer)
      .description("The ID of the property to retrieve. This will return a single property.")
    optional(:limit)
      .filled(:integer)
      .description("The maximum number of properties to retrieve. Default is 100.")
    optional(:loinc_code)
      .filled(:string)
      .description("The LOINC code to filter properties by. This must be an exact match.")
    optional(:mnemonic)
      .filled(:string)
      .description("The mnemonic to filter properties by. This can be a full or partial mnemonic.")
    optional(:description)
      .filled(:string)
      .description("The description to filter properties by. This can be a full or partial description.")
  end

  def call(limit: 100, id: nil, loinc_code: nil, mnemonic: nil, description: nil)
    properties = []
    if id
      property = Property.find_by(id: id)
      properties << property if property
    else
      properties = Property.order(:loinc_code).limit(limit)
      properties = properties.where(loinc_code: loinc_code) if loinc_code
      properties = properties.where("mnemonic ILIKE ?", "%#{mnemonic}%") if mnemonic
      properties = properties.where("description ILIKE ?", "%#{description}%") if description
    end  
    properties.map do |property|
      {
        id: property.id,
        mnemonic: property.mnemonic,
        loinc_code: property.loinc_code,
        units_of_measure: property.units_of_measure,
        low_limit: property.low_limit&.to_f,
        high_limit: property.high_limit&.to_f,
        data_type: property.data_type,
        description: property.description,
        created_at: property.created_at.iso8601,
        updated_at: property.updated_at.iso8601
      }
    end
  end
end
