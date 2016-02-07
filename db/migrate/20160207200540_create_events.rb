class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.belongs_to :organization, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.string :state, null: false, default: 'new'
      t.text :description

      t.timestamps null: false
    end
  end
end
