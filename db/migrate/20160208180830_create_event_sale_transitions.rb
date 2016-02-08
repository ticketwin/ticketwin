class CreateEventSaleTransitions < ActiveRecord::Migration
  def change
    create_table :event_sale_transitions do |t|
      t.string :to_state, null: false
      t.text :metadata, default: "{}"
      t.integer :sort_key, null: false
      t.integer :event_sale_id, null: false
      t.boolean :most_recent, null: false
      t.timestamps null: false
    end

    add_index(:event_sale_transitions,
              [:event_sale_id, :sort_key],
              unique: true,
              name: "index_event_sale_transitions_parent_sort")
    add_index(:event_sale_transitions,
              [:event_sale_id, :most_recent],
              unique: true,
              where: 'most_recent',
              name: "index_event_sale_transitions_parent_most_recent")
  end
end
