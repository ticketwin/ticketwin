class CreateBoxOffices < ActiveRecord::Migration
  def change
    create_table :box_offices, primary_key: :box_office_id do |t|
      t.belongs_to :event, index: true
      t.timestamps null: false
    end
  end
end
