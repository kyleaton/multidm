class AddTeamsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :team_id
      t.string :team_name
      t.string :access_token
      t.string :user_id
      t.string :channel_id
    end
  end
end
