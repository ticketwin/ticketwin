class AddLastTouchedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_touched_at, :datetime
  end
end
