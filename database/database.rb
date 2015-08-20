class Database
  def initialize
    raise NotImplementedError
  end

  # get the next available id
  def id
    raise NotImplementedError
  end

  # insert a new url, with its shortened version
  def insert(short, url)
    raise NotImplementedError
  end

  # get an url from its shortened version
  def fetch(short)
    raise NotImplementedError
  end
end
