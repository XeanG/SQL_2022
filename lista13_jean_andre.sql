DROP TABLE IF EXISTS novelas;
CREATE TABLE novelas(
    codigo INTEGER NOT NULL,
    nome VARCHAR(30) NOT NULL,
    data_primeiro_capitulo DATE NOT NULL,
    data_ultimo_capitulo DATE NOT NULL,
    horario_exibicao TIME,
    PRIMARY KEY (nome)
);
INSERT INTO novelas VALUES (1 ,'Mulheres da Areia','1990-01-01','1990-06-01','21:00:00');
INSERT INTO novelas VALUES (2 ,'Misterios de uma vida','2022-01-01','2022-04-11','21:00:00');
INSERT INTO novelas VALUES (3 ,'Vida da gente','2010-01-01','2010-04-11','18:00:00');
INSERT INTO novelas VALUES (4 ,'Quanto mais vida melhor','2010-01-01','2010-04-11','18:00:00');
INSERT INTO novelas VALUES (5 ,'Convida a gente','2010-01-01','2010-04-11','18:00:00');
INSERT INTO novelas VALUES (6 ,'Vida','2010-01-01','2010-04-11','18:00:00');
INSERT INTO novelas VALUES (7 ,'O clone','2022-01-01','2022-04-11', 'NULL');

DROP TABLE IF EXISTS atores;
CREATE TABLE atores (
    codigo INTEGER NOT NULL,
    nome VARCHAR(30) NOT NULL,
    idade NUMERIC(3) NOT NULL,
    cidade VARCHAR(30) NOT NULL,
    salario NUMERIC (10,2) NOT NULL,
    sexo VARCHAR(1) NOT NULL,
    PRIMARY KEY (codigo)
);

INSERT INTO atores VALUES (11, 'Gloria Pires' , '50' ,'Rio de janeiro','50000','F');
INSERT INTO atores VALUES (12, 'Antonio Fagundes' , '65' ,'Marau','150000','M');
INSERT INTO atores VALUES (13, 'Marcos Frota' , '65' ,'Floripa','300','M');
INSERT INTO atores VALUES (14, 'Nivia Maria' , '50' ,'Salvador','150000','F');

DROP TABLE IF EXISTS personagens;
CREATE TABLE personagens(
    codigo INTEGER NOT NULL,
    nome VARCHAR(30) NOT NULL,
    idade NUMERIC(3) NOT NULL,
    situacao_financeira VARCHAR(1) NOT NULL,
    cod_ator INTEGER NOT NULL,
    PRIMARY KEY (codigo),
    FOREIGN KEY (cod_ator) REFERENCES atores (codigo)
);

INSERT INTO personagens VALUES (111, 'Ruth' , '50' , 'C' , '11');
INSERT INTO personagens VALUES (112, 'Raquel' , '50' , 'C' , '11');
INSERT INTO personagens VALUES (113, 'Tonho da Lua' , '30' , 'C' , '13');

DROP TABLE IF EXISTS novelas_personagens;
CREATE TABLE novelas_personagens(
    cod_novela VARCHAR(1) NOT NULL,
    cod_personagem VARCHAR (3) NOT NULL,
    FOREIGN KEY (cod_novela) REFERENCES novelas (codigo),
    FOREIGN KEY (cod_personagem) REFERENCES personagens (codigo)
);

INSERT INTO novelas_personagens VALUES (1,111);
INSERT INTO novelas_personagens VALUES (1,112);
INSERT INTO novelas_personagens VALUES (1,113);

DROP TABLE IF EXISTS capitulos;
CREATE TABLE capitulos(
    codigo INTEGER NOT NULL,
    nome VARCHAR(30) NOT NULL,
    data_exibicao DATE NOT NULL,
    cod_novela INTEGER NOT NULL,
    PRIMARY KEY (codigo),
    FOREIGN KEY (cod_novela) REFERENCES novelas (codigo) 
);

INSERT INTO capitulos VALUES (01, 'Ultimo capitulo' , '2022-04-11' , '2');
INSERT INTO capitulos VALUES (02, 'Vai que cola' , '2022-05-03' , '1');
INSERT INTO capitulos VALUES (03, 'Agora já era' , '2022-04-01' , '2');


SELECT * FROM novelas;
SELECT * FROM atores;
SELECT * FROM personagens;
SELECT * FROM novelas_personagens;
SELECT * FROM capitulos;

SELECT data_ultimo_capitulo FROM novelas WHERE nome = 'Misterios de uma vida';
SELECT * FROM novelas WHERE horario_exibicao = 'NULL';
SELECT * FROM atores WHERE cidade LIKE 'M%';
SELECT * FROM novelas WHERE nome LIKE '%vida%';
SELECT COUNT(codigo) FROM personagens WHERE cod_ator = 11;
SELECT * FROM personagens ORDER BY nome asc; 
SELECT * FROM personagens ORDER BY idade desc;
SELECT COUNT(nome) FROM atores;
SELECT COUNT(nome) FROM novelas;
SELECT COUNT(nome) FROM atores WHERE sexo='F';
SELECT AVG(idade) FROM personagens;
SELECT COUNT(nome) FROM personagens WHERE idade<15;
SELECT DISTINCT atores.nome FROM atores INNER JOIN personagens ON (atores.codigo = personagens.cod_ator) WHERE personagens.idade = atores.idade;
SELECT MAX(salario) FROM atores;
SELECT MIN(salario) FROM atores;
SELECT SUM(salario) FROM atores;