#coding: utf-8

#require 'heroku'
#include Clockwork

#clinet=Heroku::Client.new(*Heroku::Auth.read_credentials)

#handler do |job|
#  case job
#  when 'dyno.up'
#    client.ps_scale('sharetaskboard',:type => :worker, :qty=>1)
#  when 'dyno.down'
#    client.ps_scale('sharetaskboard',:type => :worker, :qty=>0)
#  end
#end

#every(1.days, 'dyno.up', at: '10:00')
#every(1.days, 'dyno.down', at: '18:00')

