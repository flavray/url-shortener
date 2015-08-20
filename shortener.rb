require "./database/sqlite"
require "./http/response"
require "./http/server"

if __FILE__ == $0
  server = Server.new("localhost", 1234)
  database = Sqlite.new

  puts database.id

  server.run do |request|
    puts request
    Response.not_found
  end
end
