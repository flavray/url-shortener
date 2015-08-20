class Request
  attr_reader :method, :uri, :headers, :body

  # request from a TCP socket, HTTP request-line, headers and body
  def initialize(socket)
    @method, @uri = socket.gets.split
    @headers = {}

    while data = socket.gets.split(" ", 2)
      name, value = data
      break if name.empty?
      @headers[name.chop] = value.strip
    end

    @body = socket.read(@headers["Content-Length"].to_i)
  end

  def to_s
    "Request(#{@method}, #{uri})"
  end
end
