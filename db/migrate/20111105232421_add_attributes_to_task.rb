class AddAttributesToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :name, :string
    add_column :tasks, :user_id, :integer
    add_column :tasks, :weight, :float
  end
end
