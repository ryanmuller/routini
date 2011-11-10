class RenameTaskContextColumn < ActiveRecord::Migration
  def change
    rename_column :task_contexts, :context_id, :situation_id
  end
end

