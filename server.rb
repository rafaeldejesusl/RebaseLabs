require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require 'pg'


get '/tests' do
  begin
    conn = PG.connect( host: 'pgserver', dbname: 'rebaselabs', user: 'docker', password: 'docker' )
    result = conn.exec('SELECT * FROM clients').entries
    result.to_json   
  rescue => exception
    error = { message: 'Erro Interno da Aplicação' }
    status 500
    error.to_json
  end
end

get '/hello' do
  'Hello world!'
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)