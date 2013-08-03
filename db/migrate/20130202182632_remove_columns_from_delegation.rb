class RemoveColumnsFromDelegation < ActiveRecord::Migration
  def up
      remove_column :delegations,:project_id
      remove_column :delegations,:user_id
  end

  def down
  end
end
