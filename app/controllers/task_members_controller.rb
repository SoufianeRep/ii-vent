class TaskMembersController < ApplicationController
  def create
    task = Task.find(params[:task_id])
    set_task_params[:event_member_id].reject(&:blank?).each do |event_member_id|
      @task_member = TaskMember.create!(set_task_params.merge(task: task, event_member_id: event_member_id))
    end
    authorize @task_member
  end

  private

  def set_task_params
    params.require(:task_member).permit(event_member_id: [])
  end
end
