class AddMiscToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :misc, :boolean, default: false
  end
end
