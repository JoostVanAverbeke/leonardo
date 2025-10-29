class GetOrdersTool < ApplicationTool
  description <<~DESC
        This tool of the leonardo application retrieves all orders matching the given criteria.
        It's useful for retrieving a list of orders.
        The response will include the orders and their attributes.
        The orders are ordered by loinc code.
        If there are no orders, it will return an empty array.
        Matching criteria are:
        - none (all orders are returned)
        - id (exact match, returns single order)
        - limit (maximum number of orders to retrieve)
        - filler order number (exact match)
        - placer order number (exact match)
        - patient ID (exact match)
        - ordering provider ID (exact match)
        - receipt time range (start and end datetime)
        With this tool you can get the ID of each order for further operations
        like updating, retrieving related records or deleting.

        Expected response format:
        [
            {
                "id": 1,
                "placer_order_number": "PO123456",
                "filler_order_number": "FO123456",
                "priority": "routine",
                "order_status": "pending",
                "patient": {
                    "id": 1,
                    "first_name": "John",
                    "surname": "Doe",
                    "birth_date": "1990-01-01",
                    "gender": "male",
                    "national_number": "123456789"
                }
                "ordering_provider": {
                    "id": 10,
                    "mnemonic": "HP1",
                    "first_name": "Doc",
                    "surname": "Who",
                    "identifier": "PROV12345"
                },
                "relevant_clinical_information": "Patient has a history of diabetes.",
                "order_call_back_phone": "+1234567890",
                "receipt_time": "2023-10-01T12:00:00Z
                "created_at": "2023-10-01T12:00:00Z",
                "updated_at": "2023-10-01T12:00:00Z
            },
            {
                "id": 2,
                "placer_order_number": "PO654321",
                "filler_order_number": "FO654321",
                "priority": "stat",
                "order_status": "completed",
                "patient": {
                    "id": 2,
                    "first_name": "Jane",
                    "surname": "Smith",
                    "birth_date": "1985-05-15",
                    "gender": "female",
                    "national_number": "987654321"
                }
                "ordering_provider": {
                    "id": 11,
                    "mnemonic": "HP2",
                    "first_name": "Dr.",
                    "surname": "Strange",
                    "identifier": "PROV54321"
                },
                "relevant_clinical_information": "Urgent blood test required.",
                "order_call_back_phone": "+0987654321",
                "receipt_time": "2023-10-02T15:30:00Z
                "created_at": "2023-10-02T12:00:00Z",
                "updated_at": "2023-10-02T12:00:00Z
            }
        ]
    DESC
  arguments do
    optional(:id)
      .filled(:integer)
      .description("The ID of the order to retrieve. This will return a single order.")
    optional(:limit)
      .filled(:integer)
      .description("The maximum number of orders to retrieve. Default is 100.")
    optional(:filler_order_number)
      .filled(:string)
      .description("The filler order number to filter orders by. This must be an exact match.")
    optional(:placer_order_number)
      .filled(:string)
      .description("The placer order number to filter orders by. This must be an exact match.")
    optional(:patient_id)
      .filled(:integer)
      .description("The patient ID to filter orders by. This must be an exact match.")
    optional(:ordering_provider_id)
      .filled(:integer)
      .description("The ordering provider ID to filter orders by. This must be an exact match.")
    optional(:receipt_time_start)
      .filled(:date_time)
      .description("The start datetime to filter orders by receipt time range.")
    optional(:receipt_time_end)
      .filled(:date_time)
      .description("The end datetime to filter orders by receipt time range.")
  end

  def call(limit: 100, id: nil, filler_order_number: nil, placer_order_number: nil, patient_id: nil,
      ordering_provider_id: nil, receipt_time_start: nil, receipt_time_end: nil)
    orders = []
    if id
      order = Order.find_by(id: id)
      orders << order if order
    else
      orders = Order.order(:receipt_time).limit(limit)
      orders = orders.where(filler_order_number: filler_order_number) if filler_order_number
      orders = orders.where(placer_order_number: placer_order_number) if placer_order_number
      orders = orders.where(patient_id: patient_id) if patient_id
      orders = orders.where(ordering_provider_id: ordering_provider_id) if ordering_provider_id
      if receipt_time_start && receipt_time_end
        orders = orders.where(receipt_time: receipt_time_start..receipt_time_end)
      elsif receipt_time_start
        orders = orders.where("receipt_time >= ?", receipt_time_start)
      elsif receipt_time_end
        orders = orders.where("receipt_time <= ?", receipt_time_end)
      end
    end
    orders.map do |order|
      {
        id: order.id,
        placer_order_number: order.placer_order_number,
        filler_order_number: order.filler_order_number,
        priority: order.priority,
        order_status: order.order_status,
        patient: order.patient ? { 
          id: order.patient.id,
          first_name: order.patient.first_name,
          surname: order.patient.surname,
          birth_date: order.patient.birth_date.iso8601,
          gender: order.patient.gender
          national_number: order.patient.national_number
        } : nil,
        ordering_provider: order.ordering_provider ? {
          id: order.ordering_provider.id,
          mnemonic: order.ordering_provider.mnemonic,
          first_name: order.ordering_provider.first_name,
          surname: order.ordering_provider.surname
          identifier: order.ordering_provider.identifier
        } : nil,
        relevant_clinical_information: order.relevant_clinical_information,
        order_call_back_phone: order.order_call_back_phone,
        receipt_time: order.receipt_time.iso8601,
        created_at: order.created_at.iso8601,
        updated_at: order.updated_at.iso8601
      }
    end
    rescue StandardError => e
            { error: e.message }
  end
end
