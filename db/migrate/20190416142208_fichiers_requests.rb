class FichiersRequests < ActiveRecord::Migration[5.2]
  def change
  	create table fichiers_requests do |t|
  		t.integer :fichier_id
  		t.integer :request_id
  	end
  end
end
