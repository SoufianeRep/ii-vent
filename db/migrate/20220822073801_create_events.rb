class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :location
      t.date :start_date
      t.date :end_date
      t.string :name
      t.string :event_status

      t.timestamps
    end
  end
end
