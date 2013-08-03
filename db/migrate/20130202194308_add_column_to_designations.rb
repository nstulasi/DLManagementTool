class AddColumnToDesignations < ActiveRecord::Migration
  def change
    add_column :designations, :membership_id, :integer
  end
end
