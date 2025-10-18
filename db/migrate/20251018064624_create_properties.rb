class CreateProperties < ActiveRecord::Migration[8.0]
  def change
    create_table :properties do |t|
      t.string :mnemonic
      t.string :loinc_code
      t.string :units_of_measure
      t.decimal :low_limit
      t.decimal :high_limit
      t.integer :data_type
      t.string :description

      t.timestamps
    end
  end
end
