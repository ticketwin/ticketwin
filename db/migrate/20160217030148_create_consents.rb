class CreateConsents < ActiveRecord::Migration
  def change
    create_table :consents, primary_key: :consent_id do |t|
      t.belongs_to :consent_type, null: false
      t.references :consentable, polymorphic: true, index: true, null: false

      t.timestamps null: false
    end
  end
end
