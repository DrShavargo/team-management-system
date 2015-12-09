class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :requestor_id
      t.string  :status
      t.integer :team_id
    end
  end
end
