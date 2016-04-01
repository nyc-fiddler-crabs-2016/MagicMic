class CreateBroadcasts < ActiveRecord::Migration
   # validates :

  def change
    create_table :broadcasts do |t|
      t.string :topic
      t.datetime :datetime
      t.integer :duration
      t.references :speaker

      t.timestamps null: false
    end
  end
end
