require 'csv'
require 'pg'

def import_data(csv)
  conn = PG.connect( host: 'pgserver', dbname: 'rebaselabs', user: 'docker', password: 'docker' )
  conn.exec('DROP TABLE IF EXISTS clients;')
  conn.exec('CREATE TABLE clients (id serial primary key, cpf text, patient_name text,
    patient_email text, patient_birth_date date, patient_address text,
    patient_city text, patient_state text, doctor_crm text,
    doctor_crm_state text, doctor_name text, doctor_email text,
    exam_result_token text, exam_date date, exam_type text,
    limits_exam_type text, result_exam_type text);'
  )
  
  columns = csv.shift
  
  csv.map do |row|
    conn.exec("INSERT INTO clients(cpf, patient_name,
      patient_email, patient_birth_date, patient_address,
      patient_city, patient_state, doctor_crm,
      doctor_crm_state, doctor_name, doctor_email,
      exam_result_token, exam_date, exam_type,
      limits_exam_type, result_exam_type) VALUES ('#{row[0]}', '#{row[1]}', '#{row[2]}', '#{row[3]}',
      '#{row[4]}', '#{row[5].gsub("'", "''")}', '#{row[6]}', '#{row[7]}', '#{row[8]}', '#{row[9]}', '#{row[10]}', '#{row[11]}',
      '#{row[12]}', '#{row[13]}', '#{row[14]}', '#{row[15]}')"
    )
  end
  
  conn.close
end
