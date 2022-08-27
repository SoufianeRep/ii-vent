if @task.persisted?
  json.form render(partial: "components/subtask_form", formats: :html, locals: { event: @event, parent_task: @parent_task, task: Task.new })
  json.inserted_item(partial: "components/subtasks", formats: :html, locals: { task: @task })
else
  json.form render(partial: "components/subtask_form", formats: :html, locals: { event: @event, parent_task: @parent_task, task: Task.new })
end
