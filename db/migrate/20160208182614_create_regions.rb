class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions, primary_key: :region_id do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
