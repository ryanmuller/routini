class DefaultForTimePreference < ActiveRecord::Migration
  def change
    change_column :users, :time_offset, :integer, :default => 0
  end
end
