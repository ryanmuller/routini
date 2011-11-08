class CreateTaskContexts < ActiveRecord::Migration
  def change
    create_table :task_contexts do |t|

      t.timestamps
    end
  end
end
