class Response
  attr_reader :code, :content, :headers

  def self.ok(content)
    Response.new("200 OK", content)
  end

  def self.redirect(location)
    Response.new("301 Moved Permanently", "", ["Location: #{location}"])
  end

  def self.not_found
    Response.new("404 Not Found", "")
  end

  def to_s
    "Response(#{@code}, #{@content}, #{@headers.join(',')})"
  end

  private
  def initialize(code, content, headers = [])
    @code = code
    @content = content
    @headers = headers
  end
end
