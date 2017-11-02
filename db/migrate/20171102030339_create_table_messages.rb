class CreateTableMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
    	t.string :channel
    	t.string :user_id
    end
  end
end
