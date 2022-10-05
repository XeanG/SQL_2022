DROP TABLE IF EXISTS salas;
CREATE TABLE salas (
    numero INTEGER NOT NULL,
    descricao VARCHAR(30),
    capacidade VARCHAR(4),
    PRIMARY KEY (numero)
);

INSERT INTO salas VALUES (101, 'Sala 3D 1', '100');
INSERT INTO salas VALUES (102, 'Sala 3D 2', '100');
INSERT INTO salas VALUES (103, 'Sala Convencional 1', '150');
INSERT INTO salas VALUES (201, 'Sala Convencional 2', '100');
INSERT INTO salas VALUES (202, 'Sala 3D 3', '80');

DROP TABLE IF EXISTS diretores;
CREATE TABLE diretores (
    codigo INTEGER NOT NULL,
    nome VARCHAR(60) NOT NULL,
    PRIMARY KEY (codigo)
);

INSERT INTO diretores VALUES (1, 'Fulano de Tal da Silva');
INSERT INTO diretores VALUES (2, 'Ciclana das Neves');
INSERT INTO diretores VALUES (3, 'Josicreidson Seilayevski');

DROP TABLE IF EXISTS filmes;
CREATE TABLE filmes (
    codigo INTEGER NOT NULL,
    nome VARCHAR(50) NOT NULL,
    ano_lancamento CHAR(4) NOT NULL,
    categoria VARCHAR(30) NOT NULL,
    cod_diretor INTEGER NOT NULL,
    PRIMARY KEY (codigo),
    FOREIGN KEY (cod_diretor) REFERENCES diretores (codigo) ON DELETE CASCADE
);

INSERT INTO filmes VALUES (1, 'Titanic', '1997', 'Drama', 1);
INSERT INTO filmes VALUES (2, 'Matrix', '2001', 'Ficção', 1);
INSERT INTO filmes VALUES (3, 'A prova de fogo' , '2009' , 'Romance' , 2);
INSERT INTO filmes VALUES (4, 'Toy Story' , '1998' , 'Animação' , 3);
INSERT INTO filmes VALUES (5, 'Shrek' , '2000', 'Animação' , 2);

DROP TABLE IF EXISTS salas_filmes;
CREATE TABLE salas_filmes (
    numero_sala INTEGER NOT NULL,
    cod_filme INTEGER NOT NULL,
    data DATE NOT NULL,
    horario TIME NOT NULL,
    PRIMARY KEY (numero_sala, cod_filme),
    FOREIGN KEY (numero_sala) REFERENCES salas (numero) ON DELETE CASCADE ,
    FOREIGN KEY (cod_filme) REFERENCES filmes (codigo) ON DELETE CASCADE
);

INSERT INTO salas_filmes VALUES (101 , 1 , '14/04/2014' , '20:00' );
INSERT INTO salas_filmes VALUES (101 , 2 , '15/04/2014' , '22:00' );
INSERT INTO salas_filmes VALUES (102 , 1 , '10/04/2014' , '19:00' );
INSERT INTO salas_filmes VALUES (103 , 3 , '22/04/2014' , '16:00' );
INSERT INTO salas_filmes VALUES (201 , 4 , '14/04/2014' , '22:00' );
INSERT INTO salas_filmes VALUES (201 , 5 , '15/04/2014' , '20:00' );
INSERT INTO salas_filmes VALUES (202 , 3 , '21/04/2014' , '20:00' );

DROP TABLE IF EXISTS premios;
CREATE TABLE premios (
    codigo INTEGER NOT NULL,
    nome VARCHAR(50) NOT NULL,
    ano_premiacao CHAR(4) NOT NULL,
    cod_filme INTEGER NOT NULL,
    PRIMARY KEY (codigo),
    FOREIGN KEY (cod_filme) REFERENCES filmes (codigo) ON DELETE CASCADE
);

INSERT INTO premios VALUES (1, 'Oscar – Melhor Filme','1997','1');
INSERT INTO premios VALUES (2, 'Oscar – Melhor Diretor','1997','1');
INSERT INTO premios VALUES (3, 'Globo de ouro – Melhor Filme','1997','1');
INSERT INTO premios VALUES (4, 'Oscar – Efeitos Especiais','2002','2');
INSERT INTO premios VALUES (5, 'Globo de ouro – Melhor Animação','1999','4');
INSERT INTO premios VALUES (6, 'Globo de ouro – Melhor Animação','2001','5');
INSERT INTO premios VALUES (7, 'Oscar – Melhor Atriz Coadjuvante','1997','1');

SELECT * FROM salas;
SELECT * FROM diretores;
SELECT * FROM filmes;
SELECT * FROM salas_filmes;
SELECT * FROM premios;

SELECT nome FROM diretores;
SELECT nome FROM filmes WHERE categoria = 'Animação';
UPDATE salas SET capacidade = '200' WHERE numero = '202';
SELECT capacidade FROM salas WHERE numero='202';
UPDATE salas_filmes SET numero_sala = '202' WHERE data = '14/04/2014'; 
SELECT * FROM salas_filmes;
SELECT nome , categoria FROM filmes WHERE cod_diretor = '2';
SELECT horario FROM salas_filmes WHERE data = '15/04/2014'; 
SELECT nome, ano_premiacao FROM premios WHERE cod_filme = '2';
SELECT codigo , nome , categoria FROM filmes WHERE ano_lancamento > '1999';
DELETE FROM diretores WHERE nome = 'Fulano de Tal da Silva';
DELETE FROM filmes WHERE cod_diretor = '1';
DELETE FROM premios WHERE cod_filme < '3';
DELETE FROM salas_filmes WHERE cod_filme < '3';
SELECT * FROM diretores;
SELECT * FROM filmes;
SELECT * FROM premios;
SELECT * FROM salas_filmes;

/* foi colocado o exercicio 6 (dos deletes) por ultimo pois ele interfere nas demais tabelas c: 