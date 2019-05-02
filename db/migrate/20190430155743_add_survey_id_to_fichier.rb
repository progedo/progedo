class AddSurveyIdToFichier < ActiveRecord::Migration[5.2]
  def change
    add_column :fichiers, :survey_id, :integer
  end
end
