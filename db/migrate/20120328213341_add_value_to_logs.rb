class AddValueToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :value, :string
  end
end
