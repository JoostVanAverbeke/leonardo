class AddPatientEmailIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :patients, :email, name: :index_patients_on_email
  end
end
