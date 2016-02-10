class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships, primary_key: :membership_id do |t|
      t.belongs_to :organization, null: false, index: true
      t.belongs_to :user, null: false, index: true

      t.boolean :ownership, default: false
      t.timestamps null: false
    end
  end
end
