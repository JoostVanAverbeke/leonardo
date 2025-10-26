class CreateObservations < ActiveRecord::Migration[8.0]
  def change
    create_table :observations do |t|
      t.references :patient, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true
      t.string :value
      t.string :unit
      t.string :alternate_unit
      t.string :alternate_unit_coding_system
      t.string :references_range
      t.string :abnormal_flags
      t.integer :result_status
      t.datetime :observation_date_time
      t.datetime :analysis_date_time
      t.text :observation_comment

      t.timestamps
    end
  end
end
