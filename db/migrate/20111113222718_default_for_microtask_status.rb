class DefaultForMicrotaskStatus < ActiveRecord::Migration
  def change
    change_column :microtasks, :status, :string, :default => "incomplete"
  end
end
