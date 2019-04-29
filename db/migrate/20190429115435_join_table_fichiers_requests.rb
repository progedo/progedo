class JoinTableFichiersRequests < ActiveRecord::Migration[5.2]
  def change
  	create_join_table :fichiers, :requests do |t|
      t.index [:fichier_id, :request_id]
      t.index [:request_id, :fichier_id]
    end
  end
end
