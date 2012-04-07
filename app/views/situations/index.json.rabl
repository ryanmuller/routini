collection @situations
attributes :id, :name
child(:tasks) { attributes(:id, :name, :display_type, :time) }
