class CreateFichiers < ActiveRecord::Migration[5.2]
  def change
    create_table :fichiers do |t|
      t.string :chemin

      t.timestamps
    end
  end
end
