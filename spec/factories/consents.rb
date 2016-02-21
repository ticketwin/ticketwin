FactoryGirl.define do
  factory :consent do
    ip_address_id { IpAddress[FFaker::Internet.ip_v4_address].id }
    consent_type { ConsentType['bafter'] }
    association :consentable, factory: :organization

    trait :bafter

    trait :stripe do
      consent_type { ConsentType['stripe_connected_account_agreement'] }
    end

    trait :tos do
      association :consentable, factory: :user
      consent_type { ConsentType['terms_of_service'] }
    end
  end
end
