class AddPaperclipToPost < ActiveRecord::Migration
  def change
    add_attachment :companies, :image  
  end
end
