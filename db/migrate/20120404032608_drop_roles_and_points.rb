class DropRolesAndPoints < ActiveRecord::Migration
  def up
    drop_table :points
    drop_table :roles
    drop_table :task_roles
  end

  def down
    create_table "points", :force => true do |t|
      t.integer   "task_id"
      t.integer   "user_id"
      t.integer   "role_id"
      t.integer   "points"
      t.timestamp "created_at"
      t.timestamp "updated_at"
    end

    create_table "roles", :force => true do |t|
      t.integer   "user_id"
      t.string    "name"
      t.timestamp "created_at"
      t.timestamp "updated_at"
      t.string    "description"
    end

    create_table "task_roles", :force => true do |t|
      t.integer   "task_id"
      t.integer   "user_id"
      t.integer   "role_id"
      t.integer   "points"
      t.timestamp "created_at"
      t.timestamp "updated_at"
    end
  end
end
