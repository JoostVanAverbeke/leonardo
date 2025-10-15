class AddHcProviderEmailIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :hc_providers, :email, name: :index_hc_providers_on_email
  end
end
