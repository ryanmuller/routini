class AddDisplayPropertiesToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :display_type, :string
  end
end
