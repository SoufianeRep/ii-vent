class TasksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update]

  def create
    @event = Event.find(params[:event_id])
    @task = Task.new(set_task_params)
    if params[:task_id]
      @parent_task = Task.find(params[:task_id])
      @task.task = @parent_task
      @task.end = @parent_task.end
    end
    @task.description&.capitalize!
    @task.event = @event
    # Orgonizer auth
    authorize @event
    respond_to do |format|
      if @task.save!
        unless @task.task.nil?
          @message = Message.new(content: "A NEW TASK HAS BEEN CREATED:|#{@task.name}|by: #{current_user.full_name}")
          @message.room = @event
          @message.event_member = @event.event_members.find_by(user: User.first)
          @message.save
        end
        format.html { redirect_to event_path(@event, tab: 'tasks', subtab: @task.category) }
        format.json
      else
        format.html { redirect_to event_path(@event, tab: 'tasks'), status: :unprocessable_entity }
        format.json
      end
    end
  end

  def update
    @task = Task.find(params[:id])
    @tasks = @task.event.tasks.where(task_id: nil)
    authorize @task
    if set_task_params[:done] == "1"
      @task.status = "done"
    else
      @task.status = "pending"
    end
    # raise
    respond_to do |format|
      if @task.update!(set_task_params)
        format.text { render partial: 'shared/event_tasks', locals: { tasks: @tasks, event: @task.event }, formats: [:html] }
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
