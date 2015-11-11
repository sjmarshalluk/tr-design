class Addlogotocompanies < ActiveRecord::Migration
  def change
    add_column :companies, :logo, :string
    add_column :companies, :saturday, :string
    add_column :companies, :sunday, :string
    add_column :companies, :office_postcode, :string
    add_column :companies, :pitch, :integer
  end
end
