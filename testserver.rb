require 'socket'
require './router.rb'
require './controller/home_controller.rb'

server = TCPServer.open(3030)
loop {
  session = server.accept
  response = Routing.new(session).get_response
  session.puts response
  session.close
}