class DropCommentsTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :comments do |t|
      t.string :content, null: false
      t.integer :user_id
      t.integer :tweet_id
      t.integer :parent_id

      t.timestamps null: false
    end
  end
end
