class DropUsersTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :tweets do |t|
      t.string :content
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
