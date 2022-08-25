class TaskMembersController < ApplicationController
  def create
    event_member = EventMember.find(params[:task_member][:event_member])
    task = Task.find(params[:task_id])
    task_member = TaskMember.new(task: task, event_member: event_member)
    authorize task_member
    task_member.save!
  end

  private

  def set_task_member
    params.require(:task_member).permit(:event_member_id)
  end
end
