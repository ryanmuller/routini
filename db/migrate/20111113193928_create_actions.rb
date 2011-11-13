class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|

      t.timestamps
    end
  end
end
