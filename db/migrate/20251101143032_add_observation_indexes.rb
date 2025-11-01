class AddObservationIndexes < ActiveRecord::Migration[8.0]
  def change
    add_index :observations, [ :patient_id, :property_id, :observation_date_time, :analysis_date_time ],
      name: :index_observations_on_patient_property_obsdate_analysisdate,
      order: { observation_date_time: :desc, analysis_date_time: :desc }
    add_index :observations, [ :patient_id, :observation_date_time, :property_id, :analysis_date_time ],
      name: :index_observations_on_patient_obsdate_property_analysisdate,
      order: { observation_date_time: :desc, analysis_date_time: :desc }
    add_index :observations, [ :property_id, :observation_date_time ],
      name: :index_observations_on_property_obsdate,
      order: { observation_date_time: :desc }
    add_index :observations, [ :property_id, :analysis_date_time ],
      name: :index_observations_on_property_analysisdate,
      order: { analysis_date_time: :desc }
    add_index :observations, :result_status
  end
end
