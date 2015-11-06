class CreateA0Wayfindings < ActiveRecord::Migration
  def change
    create_table :a0_wayfindings do |t|
      t.string :first_content
      t.boolean :first_left
      t.boolean :first_right
      t.string :second_content
      t.boolean :second_left
      t.boolean :second_right
      t.string :third_content
      t.boolean :third_left
      t.boolean :third_right
      t.timestamps null: false
    end
  end
end
