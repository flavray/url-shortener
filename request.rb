class Request
  attr_reader :method, :uri

  # request from a HTTP request-line
  def initialize(line)
    data = line.split

    @method = data[0]
    @uri = data[1]
  end

  def to_s
    "Request(#{@method}, #{uri})"
  end
end
