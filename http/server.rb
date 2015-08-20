require "socket"
require "./http/request"

class Server
  def initialize(host, port)
    @server = TCPServer.new(host, port)
  end

  def run
    loop do
      socket = @server.accept

      response = yield Request.new(socket)

      headers = [
        "HTTP/1.1 #{response.code}",
        "Content-Type: text/plain",
        "Content-Length: #{response.content.length}",
        "Connection: close"
      ] + response.headers

      socket.print headers.join("\r\n")

      socket.print "\r\n#{response.content}" unless response.content.length.zero?

      socket.close
    end
  end
end
