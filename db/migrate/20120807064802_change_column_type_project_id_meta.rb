class ChangeColumnTypeProjectIdMeta < ActiveRecord::Migration
  def up
    remove_column :meta, :project_id
    add_column :meta, :project_id, :integer
  end

  def down
  end
end
