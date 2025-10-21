class AddOrderPatientIdReceiptTimeDescIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :orders, [ :patient_id, :receipt_time ],
      name: :index_orders_on_patient_id_and_receipt_time_desc,
      order: { receipt_time: :desc }
  end
end
