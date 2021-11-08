class AddMainIdtoTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :main_id, :integer
  end
end
