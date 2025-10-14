class MunicipalityAddIndexCityCountry < ActiveRecord::Migration[8.0]
  def change
    add_index :municipalities, [ :city, :country ], name: :index_municipalities_on_city_and_country
  end
end
