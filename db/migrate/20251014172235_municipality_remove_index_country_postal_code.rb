class MunicipalityRemoveIndexCountryPostalCode < ActiveRecord::Migration[8.0]
  def change
    remove_index :municipalities, name: :index_municipalities_on_country_and_postal_code
  end
end
