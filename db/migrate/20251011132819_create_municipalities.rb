class CreateMunicipalities < ActiveRecord::Migration[8.0]
  def change
    create_table :municipalities do |t|
      t.string :postal_code
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
