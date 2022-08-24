class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    authorize @event
    @markers = [
      {
        lat: @event.latitude,
        lng: @event.longitude
      }]
  end

  def new
    @event = Event.new
    authorize @event
  end
end
