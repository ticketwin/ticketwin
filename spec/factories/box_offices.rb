FactoryGirl.define do
  factory :box_office do
    state :new
    event
    start_time { 2.hours.from_now }
    end_time   { event.start_time }

    trait :open do
      state :open
      start_time { Time.zone.now }
    end

    trait :closed do
      state :closed
    end
  end
end
