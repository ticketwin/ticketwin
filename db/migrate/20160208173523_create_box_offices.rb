class CreateBoxOffices < ActiveRecord::Migration
  def change
    create_table :box_offices, primary_key: :box_office_id do |t|
      t.string :state, null: false, default: 'new'
      t.belongs_to :event, null: false

      t.datetime :start_time, null: false
      t.datetime :end_time, null: false

      t.timestamps null: false
    end
  end
end
