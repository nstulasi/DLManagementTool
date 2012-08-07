class ChangeColumnsStartDate < ActiveRecord::Migration
  def up
    remove_column :tasks, :start_at
    add_column :tasks, :start_at, :date
  end

  def down
  end
end
