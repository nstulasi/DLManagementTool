class ChangeTypeDefaultPolicies < ActiveRecord::Migration
 def up
    change_column :default_policies, :sample, :text
    change_column :default_policies, :hint, :text
end
def down
    # This might cause trouble if you have strings longer
    # than 255 characters.
    change_column :default_polices, :sample, :string
    change_column :default_policies, :hint, :text
end
end
