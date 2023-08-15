# Rebase Labs

Uma app web para listagem de exames médicos.

---

### Tech Stack

* Docker
* PostgreSQL
* Ruby
* Sinatra
* Javascript
* HTML
* CSS
* RSpec

---

### Projeto

O projeto consiste numa aplicação Ruby utilizando o framework Sinatra para a disponibilização dos endpoints. Além disso, o sistema deve ter um banco de dados PostgreSQL que deve importar os dados do arquivo CSV. O FrontEnd utiliza apenas o básico de HTML, CSS e JavaScript, sem frameworks. Toda a aplicação deve funcionar com conteinerização, através do Docker.

---

### Instalação

Inicialmente, faça o clone do projeto com o seguinte comando:
```bash
$ git clone git@github.com:rafaeldejesusl/RebaseLabs.git
```
Para iniciar o servidor, execute o script que roda a imagem no Docker:
```bash
$ bin/run
```
Para popular o banco de dados com as informações do CSV, entre no contêiner do servidor:
```bash
$ docker exec -it rebase-labs bash
```
E execute o arquivo que importa os dados:
```bash
$ ruby lib/import_from_csv.rb 
```

---

### Endpoints da aplicação

Request:
```bash
GET /
```

Response:
FrontEnd da aplicação

---

Request:
```bash
GET /loading
```

Response:
FrontEnd da tela de carregamento

---

Request:
```bash
GET /api/tests
```

Response:

```json
[{
   "id": "1",
   "cpf": "048.973.170-88",
   "patient_name": "Emilly Batista Neto",
   "patient_email": "gerald.crona@ebert-quigley.com",
   "patient_birth_date": "2001-03-11",
   "patient_address": "165 Rua Rafaela",
   "patient_city": "Ituverava",
   "patient_state": "Alagoas",
   "doctor_crm": "B000BJ20J4",
   "doctor_crm_state": "PI",
   "doctor_name": "Maria Luiza Pires",
   "doctor_email": "denna@wisozk.biz",
   "exam_result_token": "IQCZ17",
   "exam_date": "2021-08-05",
   "exam_type": "hemácias",
   "limits_exam_type": "45-52",
   "result_exam_type": "97"
}]
```

---

Request:
```bash
GET /api/tests/IQCZ17
```

Response:

```json
[{
   "id": "1",
   "cpf": "048.973.170-88",
   "patient_name": "Emilly Batista Neto",
   "patient_email": "gerald.crona@ebert-quigley.com",
   "patient_birth_date": "2001-03-11",
   "patient_address": "165 Rua Rafaela",
   "patient_city": "Ituverava",
   "patient_state": "Alagoas",
   "doctor_crm": "B000BJ20J4",
   "doctor_crm_state": "PI",
   "doctor_name": "Maria Luiza Pires",
   "doctor_email": "denna@wisozk.biz",
   "exam_result_token": "IQCZ17",
   "exam_date": "2021-08-05",
   "exam_type": "hemácias",
   "limits_exam_type": "45-52",
   "result_exam_type": "97"
}]
```

---

Request:
```bash
POST /api/import
```

Content:

```csv
cpf;nome paciente;email paciente;data nascimento paciente;endereço/rua paciente;cidade paciente;estado patiente;crm médico;crm médico estado;nome médico;email médico;token resultado exame;data exame;tipo exame;limites tipo exame;resultado tipo exame
048.973.170-88;Emilly Batista Neto;gerald.crona@ebert-quigley.com;2001-03-11;165 Rua Rafaela;Ituverava;Alagoas;B000BJ20J4;PI;Maria Luiza Pires;denna@wisozk.biz;IQCZ17;2021-08-05;hemácias;45-52;97
```

---

### Testes
Os testes de requisição da API foram feitos utilizando o RSpec. Para rodá-los, utilize o seguinte comando:

```bash
$ bin/test
```

---

### Feedbacks
Caso tenha alguma sugestão ou tenha encontrado algum erro no código, estou disponível para contato no meu [LinkedIn](https://www.linkedin.com/in/rafael-de-jesus-lima/)
