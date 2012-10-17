worker_processes 4
timeout 60
preload_app true

#PG ERROR 
after_fork do |server,worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
if ENV['RAILS_ENV']=='development'
  listen '/usr/local/project/sharetaskboard/tmp/unicorn.sock'
end
