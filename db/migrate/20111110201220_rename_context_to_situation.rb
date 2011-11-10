class RenameContextToSituation < ActiveRecord::Migration
  def change
    rename_table :contexts, :situations
  end
end
