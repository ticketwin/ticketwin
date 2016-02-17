class CreateConsentTypes < ActiveRecord::Migration
  def change
    create_lookup_table :consent_types
  end
end
