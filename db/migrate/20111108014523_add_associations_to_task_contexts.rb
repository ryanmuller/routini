class AddAssociationsToTaskContexts < ActiveRecord::Migration
  def change
    add_column :task_contexts, :task_id, :integer
    add_column :task_contexts, :context_id, :integer
  end
end
