class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.string :placer_order_number
      t.string :filler_order_number
      t.integer :priority
      t.integer :order_status
      t.references :patient, null: false, foreign_key: true
      t.references :ordering_provider, null: false, foreign_key: { to_table: :hc_providers }
      t.text :relevant_clinical_information
      t.string :order_call_back_phone
      t.datetime :receipt_time

      t.timestamps
    end
  end
end
