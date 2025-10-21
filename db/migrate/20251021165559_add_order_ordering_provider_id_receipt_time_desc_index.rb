class AddOrderOrderingProviderIdReceiptTimeDescIndex < ActiveRecord::Migration[8.0]
  def change
        add_index :orders, [ :ordering_provider_id, :receipt_time ],
      name: :index_orders_on_ordering_provider_id_and_receipt_time_desc,
      order: { receipt_time: :desc }
  end
end
