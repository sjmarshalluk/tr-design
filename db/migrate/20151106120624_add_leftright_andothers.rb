class AddLeftrightAndothers < ActiveRecord::Migration
  def change
    add_column :companies, :right, :boolean
    add_column :companies, :founded, :integer
    add_column :companies, :team_size, :integer
  end
end
