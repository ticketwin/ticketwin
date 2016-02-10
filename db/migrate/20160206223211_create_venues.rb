class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues, primary_key: :venue_id do |t|
      t.string :address

      t.timestamps null: false
    end
  end
end
