class AddHcProviderIdentifierIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :hc_providers, :identifier, name: :index_hc_providers_on_identifier
  end
end
