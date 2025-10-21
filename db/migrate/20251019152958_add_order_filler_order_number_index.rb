class AddOrderFillerOrderNumberIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :orders, :filler_order_number, unique: true    
  end
end
