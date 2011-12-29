class AddTimePreferenceToUser < ActiveRecord::Migration
  def change
    add_column :users, :time_offset, :integer
  end
end
