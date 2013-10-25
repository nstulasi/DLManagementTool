class ChangewebpagetoHomepage < ActiveRecord::Migration
  def up
    rename_column :users, :webpage, :homepage
    rename_column :users, :number, :contact
  end

  def down
  end
end
