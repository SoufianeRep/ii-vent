class AddTimetableToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :timetable, :boolean, default: false
  end
end
