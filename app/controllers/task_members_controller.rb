class TaskMembersController < ApplicationController
  def create
    event_member = EventMember.find(params[:task_member][:event_member])
    task = Task.find(params[:task_id])
    task_member = TaskMember.new(task: task, event_member: event_member)
    event = event_member.event
    authorize task_member
    if task_member.save!
      redirect_to event_path(event, tab: 'tasks')
    else
      redirect_to event_path(event), alert: 'Could not add member to Task Try again'
    end
  end

  private

  def set_task_member
    params.require(:task_member).permit(:event_member_id)
  end
end
