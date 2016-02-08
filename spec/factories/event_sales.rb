FactoryGirl.define do
  factory :event_sale do
    event
    state :new
    sale_start_time { 2.hours.from_now }
    sale_end_time   { event.start_time }

    trait :with_presale do
      presale_start_time { 1.minute.from_now }
      presale_end_time   { sale_start_time }
    end
  end
end
