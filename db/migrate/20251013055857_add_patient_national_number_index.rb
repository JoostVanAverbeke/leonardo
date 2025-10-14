class AddPatientNationalNumberIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :patients, :national_number, name: :index_patients_on_national_number
  end
end
