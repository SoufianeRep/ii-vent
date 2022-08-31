class TasksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update]

  def create
    @event = Event.find(params[:event_id])
    @task = Task.new(set_task_params)
    if params[:task_id]
      @parent_task = Task.find(params[:task_id])
      @task.task = @parent_task
    end
    @task.name.capitalize!
    @task.description&.capitalize!
    @task.event = @event
    # Orgonizer auth
    authorize @event
    respond_to do |format|
      if @task.save!
        format.html { redirect_to event_path(@event, tab: 'tasks', subtab: @task.category) }
        format.json
      else
        format.html { redirect_to event_path(@event, tab: 'tasks'), status: :unprocessed_entity }
        format.json
      end
    end
  end

  def update
    @task = Task.find(params[:id])
    @tasks = @task.event.tasks.select { |task| task.task.nil? }
    authorize @task
    if set_task_params[:done] == "1"
      @task.status = "done"
    else
      @task.status = "pending"
    end
    # raise
    respond_to do |format|
      if @task.update!(set_task_params)
        format.text { render partial: 'shared/event_tasks', locals: { tasks: @tasks, event: @task.event }, formats: [:html]}
        format.html { redirect_to dashboard_path }
        format.json
        # format.plain { redirect_to event_path(@task.event, tab: 'tasks', subtab: @task.category) }
      end
    end
    # keep working
  end

  private

  def set_task_params
    params.require(:task).permit(:name, :description, :category, :done, :start, :end, :task_id)
  end
end
