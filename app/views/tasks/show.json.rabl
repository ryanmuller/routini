object @task
attributes(:id, :name, :description)
child(:logs) { attributes(:id, :time, :value, :created_at) }
child(:microtasks) { attributes(:id, :name, :status) }
