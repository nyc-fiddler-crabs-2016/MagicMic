class CreateUserBroadcasts < ActiveRecord::Migration
  def change
    create_table :user_broadcasts do |t|
      t.references :user, index: true, foreign_key: true
      t.references :broadcast, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
