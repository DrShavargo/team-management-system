class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :person_id, :string
  end
end
