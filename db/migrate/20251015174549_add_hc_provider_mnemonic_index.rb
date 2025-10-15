class AddHcProviderMnemonicIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :hc_providers, :mnemonic, unique: true, name: :index_hc_providers_on_mnemonic
  end
end
