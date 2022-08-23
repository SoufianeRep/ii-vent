class EventsController < ApplicationController

  def show
    @event = Event.find[:id]
  end
end
