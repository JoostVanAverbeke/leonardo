class AddPatientSurnameFirstNameIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :patients, [ :surname, :first_name ], name: :index_patients_on_surname_and_first_name
  end
end
