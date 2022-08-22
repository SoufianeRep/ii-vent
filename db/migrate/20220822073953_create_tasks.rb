class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.references :event, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.string :status
      t.date :start
      t.date :end
      t.string :category
      t.references :task, null: true, foreign_key: true

      t.timestamps
    end
  end
end
