class ChangeDelegationName < ActiveRecord::Migration
  def up
    rename_table :delegations, :designations
  end

  def down
  end
end
