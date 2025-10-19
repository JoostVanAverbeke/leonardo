class AddPropertyMnemonicIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :properties, :mnemonic, name: :index_properties_on_mnemonic, unique: true
  end
end
