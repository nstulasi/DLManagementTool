class AddPlanneddatestoPhases < ActiveRecord::Migration
  def up
    add_column :phases, :planned_start_date, :date
    add_column :phases, :planned_end_date, :date
  end

  def down
  end
end
