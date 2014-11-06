#Jane
require 'sinatra'
require 'rufus-scheduler'
require './addons/sunset'

#listen to 0.0.0.0 instead of localhost
set :bind, '0.0.0.0'

#render index.erb
get '/' do
	erb :index
end

#decide if you want to use the sunset function
useSunsetFunction = true

#Sunset light
if useSunsetFunction 
	scheduler = Rufus::Scheduler.new
	sunsettime = Sunset.new("Bonn")

	scheduler.cron '0 1 * * *' do
		#every day at 1 am
		sunsettime = Sunset.new("Bonn")
	end

	scheduler.at sunsettime.sunset do
		#check if you are home (ping your smartphone)
		#command to turn lights on here
		get '/led_on' do
			`ruby led_on.rb` 
		end
	end
end

#Time for your code!
#we recommand to categorize your devices like:
	# Socket commands
	
	# Neon on
		get '/neon_on' do
        		`ruby neon_on.rb`
		end
	#Neon off
		get '/neon_off' do
			`ruby neon_off.rb`
		end
	#LED on
		get '/led_on' do
			`ruby led_on.rb`
		end
	#LED off
		get '/led_off' do
			`ruby led_off.rb`
		end	
		

	#tv commands
		 get '/tv_power' do
		 	`irsend SEND_ONCE tv KEY_POWER` #system call to execute the command
		 end
	#avr commands
		 get '/avr_power' do
		 	`irsend SEND_ONCE avr KEY_POWER`
		 end
	#htpc commands

		#Reboot
		get '/htpc_reboot' do
			`ruby ./addons/reboot.rb`
		end

		#Shutdown
		# get '/htpc_shutdown' do
		# 	`ruby addons/shutdown.rb`
		# end
#the pattern is: '/<devicename>_<function>_<functionparameter>' => ie. 'avr_channel_hdmi1'

#but those are just single commands, lets get a bit more fancy
#you can tell jane to execute a bunch of commands on one http get, we call those *actions*
	#actions
		 get '/action_power_all' do
		 	`irsend SEND_ONCE tv KEY_POWER`
		   	sleep(2)
		 	`irsend SEND_ONCE avr KEY_POWER` 
		 end
#since actions might controll more than ist one device, the naming pattern is a bit different
#pattern: '/action_<actionname>_<actionparameter>' => ie. 'action_watch_dvd'

