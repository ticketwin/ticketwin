FactoryGirl.define do
  factory :membership do
    user
    organization

    trait :ownership do
      ownership true
    end
  end
end
