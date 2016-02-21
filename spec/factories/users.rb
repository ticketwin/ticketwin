FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password '12345678'
    password_confirmation '12345678'

    before :create do |user|
      user.consents << build(:consent, :tos, consentable: user)
    end
  end
end
