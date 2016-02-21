class CreateIpAddresses < ActiveRecord::Migration
  def change
    create_lookup_table :ip_addresses
  end
end
