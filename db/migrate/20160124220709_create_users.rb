class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, primary_key: :user_id do |t|
      t.string :email, null: false
      t.string :password_digest
      t.string :auth_token
      t.timestamps null: false
    end
  end
end
