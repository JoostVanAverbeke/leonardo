class AddPropertyLoincCodeIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :properties, :loinc_code, name: :index_properties_on_loinc_code, unique: true
  end
end
