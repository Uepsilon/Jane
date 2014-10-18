#  http://192.168.2.101/lib/powerpi.php?action=setsocket&socket=Neonroehre&status=0
require 'net/http'
# Use Net::HTTP to fetch some html
Net::HTTP.get(URI.parse('http://192.168.2.101/lib/powerpi.php?action=setsocket&socket=Neonroehre&status=1'))
