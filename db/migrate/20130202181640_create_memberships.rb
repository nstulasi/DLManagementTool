class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :project_id
      t.integer :user_id
      t.integer :level
      t.integer :role_id

      t.timestamps
    end
  end
end
