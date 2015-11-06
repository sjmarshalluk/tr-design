class ChangeModelNameagain < ActiveRecord::Migration
  def change
    rename_table :A0_wayfindings, :wayfindings
  end
end
