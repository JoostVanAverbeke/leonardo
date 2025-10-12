class MunicipalityAddIndexCountryPostalCode < ActiveRecord::Migration[8.0]
  def change
    add_index :municipalities, [ :country, :postal_code ], name: :index_municipalities_on_country_and_postal_code
  end
end
