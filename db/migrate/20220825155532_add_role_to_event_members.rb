class AddRoleToEventMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :event_members, :role, :string
  end
end
