class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations, primary_key: :organization_id do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
