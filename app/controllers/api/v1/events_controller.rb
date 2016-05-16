class Api::V1::EventsController < ApplicationController
  include EventsDocs

  def create

  end

  private

  def event_params
    # TODO: whitelist
    params.require(:events).permit!
  end
end
