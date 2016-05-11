class DropBoxOfficeStates < ActiveRecord::Migration
  def change
    drop_table :event_sale_transitions
  end
end
