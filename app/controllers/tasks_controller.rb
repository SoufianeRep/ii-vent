class TasksController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @parent_task = Task.find(params[:task_id])
    @task = Task.new(set_task_params)
    @task.name.capitalize!
    @task.description&.capitalize!
    @task.event = @event
    @task.task = @parent_task
    # Orgonizer auth
    authorize @event
    if @task.save!
      redirect_to event_path(@event, tab: 'tasks')
    else
      redirect_to event_path(@event, tab: 'tasks'), status: :unprocessed_entity
    end
  end

  private

  def set_task_params
    params.require(:task).permit(:name, :description, :category, :start, :end, :task_id)
  end
end
