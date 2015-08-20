require "./database/sqlite"
require "./http/response"
require "./http/server"
require "./shortener/base_shortener"

if __FILE__ == $0
  server = Server.new("localhost", 1234)
  database = Sqlite.new

  server.run do |request|
    puts request

    if request.method == "POST" and request.uri == "/"
      url = request.body
      short = BaseShortener.shorten(database.id, url)
      database.insert(short, url)
      Response.ok("http://localhost:1234/#{short}")
    elsif request.method == "GET"
      short = request.uri[1..-1]
      url = database.fetch(short)
      url.nil? ? Response.not_found : Response.redirect(url)
    else
      Response.not_found
    end
  end
end
