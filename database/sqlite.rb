require "sqlite3"
require "./database/database"

class Sqlite < Database
  def initialize
    @handler = SQLite3::Database.new("database.sqlite3")

    @handler.execute <<-SQL
      CREATE TABLE IF NOT EXISTS urls (
        id INTEGER PRIMARY KEY,
        short TEXT,
        url TEXT
      );
    SQL

    fetch_next_id
  end

  def id
    @next_id
  end

  def insert(short, url)
    @handler.execute("INSERT INTO urls(short, url) VALUES (?, ?)", short, url)
    @next_id += 1
  end

  def fetch(short)
    # TODO: ? instead of %s
    @handler.execute("SELECT url FROM urls WHERE short = '%s' LIMIT 1" % short) do |url|
      return url[0]
    end

    nil
  end

  private
  def fetch_next_id
    @next_id = 1

    @handler.execute("SELECT id FROM urls ORDER BY id DESC LIMIT 1") do |id|
      @next_id = id[0].to_i + 1
    end
  end
end
