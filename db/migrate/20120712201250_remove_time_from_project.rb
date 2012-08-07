class RemoveTimeFromProject < ActiveRecord::Migration
  def up
    remove_column :projects,:duration

  def down
  end
end
