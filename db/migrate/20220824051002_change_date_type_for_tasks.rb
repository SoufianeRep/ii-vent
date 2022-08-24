class ChangeDateTypeForTasks < ActiveRecord::Migration[7.0]
  def change
    change_column :tasks, :start, :datetime
    change_column :tasks, :end, :datetime
  end
end
