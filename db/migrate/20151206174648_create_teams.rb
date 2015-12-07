class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer   :team_id
      t.string    :name
      t.datetime  :created_at
      t.string    :status
    end
  end
end
