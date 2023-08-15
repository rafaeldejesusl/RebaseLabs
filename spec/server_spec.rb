ENV['APP_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require 'sinatra'
require 'csv'
require 'json'
require_relative '../server'
require_relative '../lib/import_data'

conn = Connection.new('pgservertest', 'rebaselabs', 'docker', 'docker' )
conn.exec('CREATE TABLE clients (id serial primary key, cpf text, patient_name text,
  patient_email text, patient_birth_date date, patient_address text,
  patient_city text, patient_state text, doctor_crm text,
  doctor_crm_state text, doctor_name text, doctor_email text,
  exam_result_token text, exam_date date, exam_type text,
  limits_exam_type text, result_exam_type text);'
)
conn.exec("INSERT INTO clients(cpf, patient_name,
  patient_email, patient_birth_date, patient_address,
  patient_city, patient_state, doctor_crm,
  doctor_crm_state, doctor_name, doctor_email,
  exam_result_token, exam_date, exam_type,
  limits_exam_type, result_exam_type) VALUES ('040.970.170-77', 'Raul Gaudino', 'raulzito@gmail.com', '2001-11-11',
  '229 Rua Felizberto', 'Arauá', 'Sergipe', 'R000BK30J8', 'SE', 'Heloísa Camargo', 'helo_doctor@gmail.com', 'BIKZ07',
  '2021-07-02', 'hemácias', '40-72', '58'), ('940.070.160-78', 'Alice Nogueira', 'alice@gmail.com', '2002-05-10',
  '527 Rua Sadino', 'Caxias', 'Santa Catarina', 'T029MC15G6', 'SC', 'Mauro Porfírio', 'mp_doctor@gmail.com', 'RATZ38',
  '2022-03-01', 'plaquetas', '24-98', '47')"
)

describe 'app' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'get /hello' do
    get '/hello'
    
    expect(last_response.status).to be 200
    expect(last_response.body).to eq 'Hello world!'
  end

  it 'get /api/tests' do
    get '/api/tests'
    
    expect(last_response.status).to be 200
    response = JSON.parse(last_response.body)
    expect(response.length).to eq 2
    expect(response[0]['cpf']).to eq '040.970.170-77'
    expect(response[1]['cpf']).to eq '940.070.160-78'
  end

  it 'get /api/tests/:token' do
    get '/api/tests/RATZ38'
    
    expect(last_response.status).to be 200
    response = JSON.parse(last_response.body)
    expect(response.length).to eq 1
    expect(response[0]['cpf']).to eq '940.070.160-78'
  end
end