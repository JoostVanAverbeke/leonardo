class AddPatientBirthDateSurnameIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :patients, [ :birth_date, :surname ], name: :index_patients_on_birth_date_and_surname
  end
end
