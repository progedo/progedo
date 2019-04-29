class DropTableFichierRequest < ActiveRecord::Migration[5.2]
  def change
  	drop_table :fichiers_requests
  end
end
