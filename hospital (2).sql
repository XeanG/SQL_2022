DROP TABLE IF EXISTS hospital;
DROP TABLE IF EXISTS medico;
DROP TABLE IF EXISTS especialidade;
DROP TABLE IF EXISTS medico_especialidade;
DROP TABLE IF EXISTS paciente;
DROP TABLE IF EXISTS consulta;
DROP TABLE IF EXISTS exame;

CREATE TABLE hospital (
 cnpj INTEGER UNIQUE NOT NULL,
 nome VARCHAR(50) NOT NULL,
 endereco VARCHAR(200) NOT NULL,
 PRIMARY KEY (cnpj)
);

INSERT INTO hospital VALUES(39159144000120, 'Hospital IFRS','Alfredo Huch, 475');

SELECT * FROM hospital;

CREATE TABLE medico (
 crm INTEGER UNIQUE NOT NULL,
 nome VARCHAR(40) NOT NULL,
 hospital_cnpj INTEGER NOT NULL,
 PRIMARY KEY (crm),
 FOREIGN KEY (hospital_cnpj) REFERENCES hospital(cnpj)
);

INSERT INTO medico VALUES (553810,'João da Silva',39159144000120);
INSERT INTO medico VALUES (223810,'Mariana Lima',39159144000120);
INSERT INTO medico VALUES (121169,'Pedro Pereira',39159144000120);

SELECT * FROM medico;

CREATE TABLE especialidade (
 id INTEGER UNIQUE NOT NULL,
 nome VARCHAR(100),
 PRIMARY KEY (id)
);

INSERT INTO especialidade VALUES (1,'Ortopedia');
INSERT INTO especialidade VALUES (2,'Pediatria');
INSERT INTO especialidade VALUES (3,'Oftalmologia');
INSERT INTO especialidade VALUES (4,'Geriatria');
INSERT INTO especialidade VALUES (5,'Cardiologia');

SELECT * FROM especialidade;

CREATE TABLE medico_especialidade(
  id INTEGER UNIQUE NOT NULL,
  medico_crm VARCHAR(30),
  especialidade_id INTEGER,
  medico_nome VARCHAR(100),
  PRIMARY KEY (id),
  FOREIGN KEY (medico_crm) REFERENCES medico(crm),
  FOREIGN KEY (especialidade_id) REFERENCES especialidade(id),
  FOREIGN KEY (medico_nome) REFERENCES medico(nome)
);

INSERT INTO medico_especialidade VALUES (1,'553810','1','João da Silva');
INSERT INTO medico_especialidade VALUES (2,'553810','4','João da Silva');
INSERT INTO medico_especialidade VALUES (3,'223810','2','Marina Lima');
INSERT INTO medico_especialidade VALUES (4,'121169','2','Pedro Pereira');

SELECT * FROM medico_especialidade;

CREATE TABLE paciente (
 cpf INTEGER UNIQUE NOT NULL, 
 nome VARCHAR(100) NOT NULL,
 PRIMARY KEY (cpf)
);

INSERT INTO paciente VALUES (17658586072,'Fransisco Cunha');
INSERT INTO paciente VALUES (22358996072,'Rosa da Silva');
INSERT INTO paciente VALUES (09856787652,'Geraldo Otavio');

SELECT * FROM paciente;

CREATE TABLE consulta (
  id INTEGER UNIQUE NOT NULL,
  data DATE NOT NULL,
  hora TIME NOT NULL,
  diagnostico VARCHAR(200),
  medico_crm INTEGER NOT NULL,
  paciente_cpf INTEGER NOT NULL,
  medico_nome VARCHAR(100),
  PRIMARY KEY (id),
  FOREIGN KEY (medico_crm) REFERENCES medico(crm),
  FOREIGN KEY (paciente_cpf) REFERENCES paciente(cpf),
  FOREIGN KEY (medico_nome) REFERENCES medico(nome)
);

INSERT INTO consulta VALUES (1,'2013-08-10','09:00:00','Olha o coração',223810,09856787652,'Mariana Lima');
INSERT INTO consulta VALUES (2,'2013-08-10','10:00:00','Repetir os exames',553810,22358996072,'João da Silva');
INSERT INTO consulta VALUES (3,'2013-09-16','09:00:00','Precisa rx',553810,09856787652,'João da Silva');


SELECT * FROM consulta;

CREATE TABLE exame(
 id INTEGER UNIQUE NOT NULL,
 descricao VARCHAR(200) NOT NULL,
 data DATE NOT NULL,
 valor INTEGER NOT NULL,
 consulta_id INTEGER NOT NULL,
 medico_crm INTEGER NOT NULL,
 cpf_paciente INTEGER NOT NULL,
 nome_paciente VARCHAR(100) NOT NULL,
 medico_nome VARCHAR(100) NOT NULL,
 especialidade_medico VARCHAR(100) NOT NULL,
 PRIMARY KEY (id),
 FOREIGN KEY (consulta_id) REFERENCES consulta(id),
 FOREIGN KEY (medico_crm) REFERENCES medico(crm),
 FOREIGN KEY (cpf_paciente) REFERENCES paciente(cpf),
 FOREIGN KEY (nome_paciente) REFERENCES paciente(nome),
 FOREIGN KEY (medico_nome) REFERENCES medico(nome),
 FOREIGN KEY (especialidade_medico) REFERENCES especialidade(nome)
);

INSERT INTO exame VALUES (1,'exame1','2013-09-11',100,1,223810,09856787652,'Geraldo Otavio','Mariana Lima','Pedritria');
INSERT INTO exame VALUES (2,'exame2','2013-09-10',100,2,553810,22358996072, 'Rosa Da Silva','João da Silva','Ortopedia e Geriatria');
INSERT INTO exame VALUES (3,'exame3','2013-01-01',100,2,553810,22358996072, 'Rosa Da Silva','João da Silva','Ortopedia e Geriatria' );
INSERT INTO exame VALUES (4,'exame4','2013-04-02',50,3,553810,09856787652,'Geraldo Otavio','João da Silva','Ortopedia e Geriatria');
INSERT INTO exame VALUES (5,'exame5','2013-02-07',200,1,223810,09856787652,'Geraldo Otavio','Mariana Lima','Pedriatria');

SELECT * FROM exame;

/*2)*/

SELECT * FROM exame WHERE cpf_paciente = 09856787652;


/*3)*/

SELECT medico_nome FROM medico_especialidade WHERE especialidade_id='2';

/*4)*/

SELECT COUNT('exame'),medico_nome FROM exame GROUP BY exame.medico_crm;
'Ortopedia e Geriatria'

/*5)*/

SELECT SUM(valor),nome_paciente FROM exame GROUP BY cpf_paciente;

/*6)*/

SELECT DISTINCT nome_paciente FROM exame WHERE medico_crm=223810;

/*7)*/

SELECT COUNT('nome_paciente'),especialidade_medico FROM exame GROUP BY medico_crm;

/*8)*/

SELECT nome FROM medico ORDER BY nome asc;

/*9)*/

SELECT COUNT('nome') FROM paciente; 

/*10)*/

SELECT medico_nome FROM consulta WHERE data='2013-08-10';

/*11)*/

DELETE FROM medico WHERE crm=223810;

SELECT * FROM medico;