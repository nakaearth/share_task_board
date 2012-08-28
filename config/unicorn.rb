worker_processes 4
timeout 15
preload_app true

#PG ERROR 
after_fork do |server,worker|
  define?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
