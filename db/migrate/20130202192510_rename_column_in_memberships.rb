class RenameColumnInMemberships < ActiveRecord::Migration
  def up
    rename_column :memberships, :role_id, :designation_id
  end

  def down
  end
end
