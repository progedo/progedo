class AddBackOfficeToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :back_office, :boolean
  end
end
