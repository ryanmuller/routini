class RenameActionToMicrotask < ActiveRecord::Migration
  def change
    rename_table :actions, :microtasks
  end
end
