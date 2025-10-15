class AddHcProviderBirthDateSurnameIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :hc_providers, [ :birth_date, :surname ], name: :index_hc_providers_on_birth_date_and_surname
  end
end
