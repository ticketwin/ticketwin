class Api::V1::EventsController < ApplicationController
  include EventsDocs

  def create
    @event = Event.new(event_params)

    if @event.save
      render :show, status: :created
    else
      render_model_errors(@event.errors.full_messages)
    end
  end

  private

  def event_params
    # TODO: whitelist
    params.require(:events).permit!
  end
end
