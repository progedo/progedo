class AddSurveyIdToFichier < ActiveRecord::Migration[5.2]
  def change
  	add_column :fichiers, :survey_id, :integer
	add_index :fichiers, :survey_id
  end
end
