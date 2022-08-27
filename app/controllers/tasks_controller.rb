class TasksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update]

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
    respond_to do |format|
      if @task.save!
        format.html { redirect_to event_path(@event, tab: 'tasks') }
        format.json
      else
        format.html { redirect_to event_path(@event, tab: 'tasks'), status: :unprocessed_entity }
        format.json
      end
    end
  end

  def update
    @task = Task.find(params[:id])
    authorize @task
    @task.update!(set_task_params)
    # keep working
  end

  private

  def set_task_params
    params.require(:task).permit(:name, :description, :category, :done, :start, :end, :task_id)
  end
end
