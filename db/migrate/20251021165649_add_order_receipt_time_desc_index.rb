class AddOrderReceiptTimeDescIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :orders, :receipt_time, name: :index_orders_on_receipt_time_desc,
      order: { receipt_time: :desc }
  end
end
