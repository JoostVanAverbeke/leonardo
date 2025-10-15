class AddHcProviderSurnameFirstNameIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :hc_providers, [ :surname, :first_name ], name: :index_hc_providers_on_surname_and_first_name
  end
end
