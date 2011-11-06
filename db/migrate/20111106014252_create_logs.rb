class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.integer :task_id
      t.integer :time

      t.timestamps
    end
  end
end
