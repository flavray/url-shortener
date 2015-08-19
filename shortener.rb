require "./http/response"
require "./http/server"

if __FILE__ == $0
  server = Server.new("localhost", 1234)

  server.run do |request|
    puts request
    Response.not_found
  end
end
