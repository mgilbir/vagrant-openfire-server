
require 'socket'

def local_ip
  orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true  # turn off reverse DNS resolution temporarily

  UDPSocket.open do |s|
    s.connect '64.233.187.99', 1
    s.addr.last
  end
ensure
  Socket.do_not_reverse_lookup = orig
end

openfire Mash.new unless attribute?("openfire")
openfire[:admin] = Mash.new unless openfire.has_key?(:admin)
openfire[:admin][:password] = "openfire"
openfire[:db] = Mash.new unless openfire.has_key?(:db)
openfire[:db][:host] = local_ip unless openfire[:db].has_key?(:host)
openfire[:db][:user] = "openfire" unless openfire[:db].has_key?(:user)
openfire[:db][:password] = "openfire" unless openfire[:db].has_key?(:password)
openfire[:db][:database] = "openfire" unless openfire[:db].has_key?(:database)
