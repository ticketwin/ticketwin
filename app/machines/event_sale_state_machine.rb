class EventSaleStateMachine
  include Statesman::Machine
  include Statesman::Events

  state :new, initial: true
  state :pre_sale
  state :on_sale
  state :post_sale

  event :start_presale do
    transition from: :new,      to: :pre_sale
  end

  event :start do
    transition from: :new,      to: :on_sale
    transition from: :pre_sale, to: :on_sale
  end

  event :end do
    transition from: :pre_sale, to: :post_sale
    transition from: :on_sale,  to: :post_sale
  end

  event :cancel do
    transition from: :new,      to: :canceled
    transition from: :pre_sale, to: :canceled
    transition from: :on_sale,  to: :canceled
  end

  after_transition do |model, transition|
    model.state = transition.to_state
    model.save!
  end
end
