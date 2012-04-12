collection @situations
attributes :id, :name
child(:tasks) do 
  child(:logs) do
    attributes(:id, :value, :time, :created_at)
  end
  attributes(:id, :name, :display_type, :time) 
  node(:value_pts) { |task| task.values_graph }
  node(:log_pts)   { |task| task.logs_graph }
  node(:todos)     { |task| task.microtasks.incomplete.collect { |m| m.name } }
  node(:dones)     { |task| task.microtasks.complete.created_today(task.user.time_offset.hours).collect { |m| m.name }}
end
