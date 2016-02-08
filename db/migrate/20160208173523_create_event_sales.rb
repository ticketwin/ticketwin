class CreateEventSales < ActiveRecord::Migration
  def change
    create_table :event_sales do |t|
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
