class AddCompaniesCol < ActiveRecord::Migration
  def change
    add_column :companies, :name, :string
    add_column :companies, :mission, :text
    add_column :companies, :tech_stack, :text
    add_column :companies, :hiring_saturday, :string
    add_column :companies, :hiring_sunday, :string
    add_column :companies, :hiring_contact, :string
  end
end
