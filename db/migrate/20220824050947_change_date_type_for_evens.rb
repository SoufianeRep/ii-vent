class ChangeDateTypeForEvens < ActiveRecord::Migration[7.0]
  def change
    change_column :events, :start_date, :datetime
    change_column :events, :end_date, :datetime

  end
end
