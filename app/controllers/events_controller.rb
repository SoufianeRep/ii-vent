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
end
