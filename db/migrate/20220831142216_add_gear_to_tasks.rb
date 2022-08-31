class AddGearToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :gear, :boolean, default: false
  end
end
