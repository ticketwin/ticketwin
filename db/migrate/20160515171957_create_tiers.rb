class CreateTiers < ActiveRecord::Migration
  def change
    create_table :tiers, primary_key: :tier_id do |t|
      t.string  :name,          null: false
      t.integer :display_order, null: false, default: 0
      t.text    :description
      t.integer :max_tickets,   null: false, default: 0, limit: 8
      t.string  :state,         null: false, default: 'draft'

      t.belongs_to :box_office, index: true

      t.timestamps null: false
    end
  end
end
