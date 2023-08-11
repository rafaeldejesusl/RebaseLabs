require 'pg'

class Connection
  attr_accessor :host, :dbname, :user, :password

  def initialize(host, dbname, user, password)
    @host = host
    @dbname = dbname
    @user = user
    @password = password
  end

  def exec(query)
    conn = PG.connect(host: @host, dbname: @dbname, user: @user, password: @password)
    result = conn.exec(query)
    conn.close
    result
  end
end