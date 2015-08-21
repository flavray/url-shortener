#!/usr/bin/env ruby

require "./database/sqlite"
require "./http/response"
require "./http/server"
require "./options/parser"
require "./shortener/base_shortener"

if __FILE__ == $0
  options, status = Parser.parse(ARGV)

  unless status
    puts options.opts
    exit
  end

  server = Server.new("localhost", options.port)
  database = Sqlite.new(options.database)

  server.run do |request|
    puts request

    if request.method == "POST" and request.uri == "/"
      url = request.body
      short = BaseShortener.shorten(database.id, url)
      database.insert(short, url)
      Response.ok("#{options.domain}#{short}")
    elsif request.method == "GET"
      short = request.uri[1..-1]
      url = database.fetch(short)
      url.nil? ? Response.not_found : Response.redirect(url)
    else
      Response.not_found
    end
  end
end
