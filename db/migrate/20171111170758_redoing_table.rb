class RedoingTable < ActiveRecord::Migration[5.1]
  def change
  	remove_column :messages, :channel
  	remove_column :messages, :channel_id

  	add_column :messages, :team_id, :string
  	add_column :messages, :user_name, :string
  end
end
