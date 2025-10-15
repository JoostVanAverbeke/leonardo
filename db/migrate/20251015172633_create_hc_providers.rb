class CreateHcProviders < ActiveRecord::Migration[8.0]
  def change
    create_table :hc_providers do |t|
      t.string :mnemonic
      t.string :first_name
      t.string :surname
      t.date :birth_date
      t.integer :gender
      t.string :email
      t.string :phone
      t.string :mobile_phone
      t.string :internet
      t.string :address_line1
      t.string :address_line2
      t.references :municipality, null: false, foreign_key: true
      t.string :identifier
      t.string :title

      t.timestamps
    end
  end
end
