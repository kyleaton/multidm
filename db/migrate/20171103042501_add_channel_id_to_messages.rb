class AddChannelIdToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :channel_id, :string
  end
end
