class ChangeColumnTypeFromStringToText < ActiveRecord::Migration
  def up
    change_table :meta do |t|
      t.change :stream_xml, :text
    end
  end

  def down
    
  end
end
