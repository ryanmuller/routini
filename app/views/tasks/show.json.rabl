object @task
attributes(:id, :name, :description)
child(:logs) { attributes(:id, :time, :value) }
child(:microtasks) { attributes(:id, :name, :status) }
