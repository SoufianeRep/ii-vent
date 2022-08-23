class AddDefaultPendingToTasksForStatus < ActiveRecord::Migration[7.0]
  def change
    change_column_default :tasks, :status, from: nil, to: "pending"
  end
end
