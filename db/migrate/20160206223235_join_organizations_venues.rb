class JoinOrganizationsVenues < ActiveRecord::Migration
  def change
    create_table :organizations_venues, id: false do |t|
      t.belongs_to :organization, index: true
      t.belongs_to :venue, index: true
    end
  end
end
