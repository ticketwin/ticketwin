class Consent < ActiveRecord::Base
  belongs_to :consentable, polymorphic: true
  lookup_for :consent_type
  lookup_for :ip_address
end
