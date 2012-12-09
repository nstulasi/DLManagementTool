class LengthenMetaDatatypes < ActiveRecord::Migration
  def up
    change_column :meta, :stream_xml, :text
    change_column :meta, :structure_xml, :text
    change_column :meta, :space_xml, :text
    change_column :meta, :scenario_xml, :text
    change_column :meta, :society_xml, :text
end
def down
    
end
end
