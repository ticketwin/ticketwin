class CreateTierTransitions < ActiveRecord::Migration
  def change
    create_table :tier_transitions, primary_key: :tier_transition_id do |t|
      t.string :to_state, null: false
      t.text :metadata, default: "{}"
      t.integer :sort_key, null: false
      t.integer :tier_id, null: false
      t.boolean :most_recent, null: false
      t.timestamps null: false
    end

    add_index(:tier_transitions,
              [:tier_id, :sort_key],
              unique: true,
              name: "index_tier_transitions_parent_sort")
    add_index(:tier_transitions,
              [:tier_id, :most_recent],
              unique: true,
              where: 'most_recent',
              name: "index_tier_transitions_parent_most_recent")
  end
end
