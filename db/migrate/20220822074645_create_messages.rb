class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :event_member, null: false, foreign_key: true
      t.references :room, polymorphic: true, null: false
      t.text :content

      t.timestamps
    end
  end
end
