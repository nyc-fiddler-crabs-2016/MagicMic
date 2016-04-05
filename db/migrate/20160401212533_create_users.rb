class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false, unique: true
      t.string :password_digest, null: false, unique: true
      t.string :email, null: false, unique: true
      t.string :phone_number

      t.timestamps null: false
    end
  end
end
