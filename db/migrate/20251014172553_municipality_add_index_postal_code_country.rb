class MunicipalityAddIndexPostalCodeCountry < ActiveRecord::Migration[8.0]
  def change
    add_index :municipalities, [ :postal_code, :country ], name: :index_municipalities_on_postal_code_and_country
  end
end
