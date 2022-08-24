class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    authorize @event
    @markers = [
      {
        lat: @event.latitude,
        lng: @event.longitude
      }
    ]
    @tasks = @event.tasks.where(task_id: nil)
  end

  def new
    @event = Event.new
    authorize @event
  end
end
