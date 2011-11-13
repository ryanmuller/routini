class AddStatusToMicrotasks < ActiveRecord::Migration
  def change
    add_column :microtasks, :status, :string
  end
end
