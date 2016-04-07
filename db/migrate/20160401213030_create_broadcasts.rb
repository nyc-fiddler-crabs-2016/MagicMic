class CreateBroadcasts < ActiveRecord::Migration
   # validates :

  def change
    create_table :broadcasts do |t|
      t.string :topic, null: false
      t.datetime :datetime
      t.integer :duration, default: 60
      t.references :speaker

      t.timestamps null: false
    end
  end
end

