require "./response"
require "./server"

if __FILE__ == $0
  server = Server.new("localhost", 1234)

  server.run do |line|
    Response.not_found
  end
end
