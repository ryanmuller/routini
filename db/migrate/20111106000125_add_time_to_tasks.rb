class AddTimeToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :time, :integer, :default => 600
  end
end
