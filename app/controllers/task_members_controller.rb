class TaskMembersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    task = Task.find(params[:task_id])
    task_member = TaskMember.new(task_member_params)
    task_member.task = task
    event = task.event
    authorize task_member
    if task_member.save
      redirect_to event_path(event, tab: 'tasks' )
    else
      p task_member.errors.messages
      redirect_to event_path(event), status: :unprocessable_entity, alert: 'Could not add member to Task Try again'
    end
  end

  private

  def task_member_params
    params.require(:task_member).permit(:event_member_id)
  end
end
