class RemoveColumnInMemberships < ActiveRecord::Migration
  def up
    remove_column :memberships, :designation_id
   
  end

  def down
  end
end
