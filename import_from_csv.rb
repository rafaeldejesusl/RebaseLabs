require 'csv'
require 'pg'

conn = PG.connect( host: 'pgserver', dbname: 'rebaselabs', user: 'docker', password: 'docker' )
conn.exec('CREATE TABLE clients (cpf text, nome_paciente text,
  email_paciente text, data_nascimento_paciente date, endereco_paciente text,
  cidade_paciente text, estado_paciente text, crm_medico text,
  crm_medico_estado text, nome_medico text, email_medico text,
  token_resultado_exame text, data_exame date, tipo_exame text,
  limites_tipo_exame text, resultado_tipo_exame text);'
)
rows = CSV.read("./data.csv", col_sep: ';')

columns = rows.shift

rows.map do |row|
  conn.exec("INSERT INTO clients VALUES ('#{row[0]}', '#{row[1]}', '#{row[2]}', '#{row[3]}',
    '#{row[4]}', '#{row[5].gsub("'", "''")}', '#{row[6]}', '#{row[7]}', '#{row[8]}', '#{row[9]}', '#{row[10]}', '#{row[11]}',
    '#{row[12]}', '#{row[13]}', '#{row[14]}', '#{row[15]}')"
  )
end