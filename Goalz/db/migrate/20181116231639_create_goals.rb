class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.string :goal_title, null: false
      t.text :goal_details
      t.integer :user_id, null: false
      t.boolean :private, default: false
      t.boolean :completed, default: false
      t.timestamps
    end
    add_index :goals, :user_id
  end
end
