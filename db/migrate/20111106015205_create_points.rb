class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :task_id
      t.integer :user_id
      t.integer :role_id
      t.integer :points

      t.timestamps
    end
  end
end
