#coding: utf-8

desc "share task board cron tab"
task :update_status_finish => :environment do
  Task.finished
end
