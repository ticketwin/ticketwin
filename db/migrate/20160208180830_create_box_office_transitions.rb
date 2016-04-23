class CreateBoxOfficeTransitions < ActiveRecord::Migration
  def change
    create_table :box_office_transitions do |t|
      t.string :to_state, null: false
      t.text :metadata, default: "{}"
      t.integer :sort_key, null: false
      t.integer :box_office_id, null: false
      t.boolean :most_recent, null: false
      t.timestamps null: false
    end

    add_index(:box_office_transitions,
              [:box_office_id, :sort_key],
              unique: true,
              name: "index_box_office_transitions_parent_sort")
    add_index(:box_office_transitions,
              [:box_office_id, :most_recent],
              unique: true,
              where: 'most_recent',
              name: "index_box_office_transitions_parent_most_recent")
  end
end
