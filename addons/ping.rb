require 'rubygems'
require 'net/ping'

include Net

Ping::TCP.service_check = true

hosts = ['192.168.2.109', '192.168.2.86']
threads = []
ping_objects = []
status = false

hosts.each do |ip|
   ping_objects << Net::Ping::TCP.new(ip)
   threads << Thread.new(ip, ping_objects.last) do |ip, p|
     loop do
    	if p.ping == true
        #Set status
    		status = true

    		else
          status = false
    		sleep 240
    	end
       #execute command
       sleep 240
     end
   end
end
threads.each { |th| th.join }

