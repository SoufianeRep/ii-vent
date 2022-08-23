class AddDefaultUpcomingToEventsForEventStatus < ActiveRecord::Migration[7.0]
  def change
    change_column_default :events, :event_status, from: nil, to: "upcoming"
  end
end
