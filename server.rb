require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require 'pg'
require 'sinatra/cors'
require_relative 'import_data'
require_relative 'importer'

set :allow_origin, "*"
set :allow_methods, "GET,DELETE,PATCH,OPTIONS"
set :allow_headers, "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept, if-modified-since"
set :expose_headers, "location,link"
set :public_folder, __dir__ + '/static'


get '/' do
  File.open('index.html')
end

get '/loading' do
  File.open('loading.html')
end

get '/tests' do
  begin
    conn = PG.connect( host: 'pgserver', dbname: 'rebaselabs', user: 'docker', password: 'docker' )
    result = conn.exec('SELECT * FROM clients').entries
    result.to_json   
  rescue => exception
    error = { message: 'Erro Interno da Aplicação' }
    status 500
    error.to_json
  ensure
    conn.close
  end
end

get '/tests/:token' do
  begin
    conn = PG.connect( host: 'pgserver', dbname: 'rebaselabs', user: 'docker', password: 'docker' )
    result = conn.exec("SELECT * FROM clients WHERE exam_result_token = '#{params['token']}'").entries
    result.to_json   
  rescue => exception
    error = { message: 'Erro Interno da Aplicação' }
    status 500
    error.to_json
  ensure
    conn.close
  end
end

post '/import' do
  begin
    file = params[:file][:tempfile]
  
    Importer.perform_async(CSV.read(file, col_sep: ';').to_json)
  
    redirect '/loading'   
  rescue => exception
    redirect '/'
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