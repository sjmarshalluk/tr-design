class AddRelationalColumns < ActiveRecord::Migration
  def change
    add_column :companies, :city_id, :integer
  end
end
