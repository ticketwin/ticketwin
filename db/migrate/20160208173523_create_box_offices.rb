class CreateBoxOffices < ActiveRecord::Migration
  def change
    create_table :box_offices, primary_key: :box_office_id do |t|
      t.string :state, null: false, default: 'new'
      t.belongs_to :event, null: false

      t.datetime :presale_start_time
      t.datetime :presale_end_time
      t.datetime :sale_start_time
      t.datetime :sale_end_time

      t.timestamps null: false
    end
  end
end
