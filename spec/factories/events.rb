FactoryGirl.define do
  factory :event do
    name         { FFaker::Conference.name }
    organization
    box_office
    start_time   { 1.day.from_now }
    end_time     { 3.days.from_now }
    description  { FFaker::DizzleIpsum.paragraph }
    state        :new

    trait :published do
      state :published
    end

    trait :concluded do
      state      :concluded
      start_time { 1.week.ago }
      end_time   { 1.day.ago }
    end

    trait :cancelled do
      state :cancelled
    end
  end
end
