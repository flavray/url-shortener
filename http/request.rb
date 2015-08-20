class Request
  attr_reader :method, :uri, :headers, :body

  # request from a TCP socket, HTTP request-line, headers and body
  def initialize(socket)
    # read request-line
    @method, @uri = socket.gets.split
    @headers = {}

    # read headers
    loop do
      name, value = socket.gets.split(" ", 2)
      break if name.empty?
      @headers[name.chop] = value.strip
    end

    # read body
    @body = socket.read(@headers["Content-Length"].to_i)
  end

  def to_s
    "Request(#{@method}, #{uri})"
  end
end
