DROP TABLE IF EXISTS carro, pessoa;
CREATE TABLE IF NOT EXISTS pessoa (
id_pessoa INTEGER PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
nascimento DATE
);
CREATE TABLE IF NOT EXISTS carro (
id_carro INTEGER PRIMARY KEY,
placa CHAR(7) NOT NULL,
ano INTEGER,
id_pessoa INTEGER NOT NULL,
FOREIGN KEY (id_pessoa)
REFERENCES pessoa(id_pessoa)
ON DELETE CASCADE
);

 exericio 1
EXPLAIN ANALYZE
SELECT *
FROM pessoa
WHERE nome = 'Ana Silva';

CREATE INDEX idx_pessoa_nome ON pessoa (nome);


 exericio 2
EXPLAIN ANALYZE
SELECT * FROM pessoa
WHERE nascimento >= DATE '1970-01-01';

CREATE INDEX idx_pessoa_nascimento ON pessoa (nascimento);

DROP INDEX IF EXISTS idx_pessoa_nascimento;

EXPLAIN ANALYZE
SELECT * FROM pessoa
WHERE nascimento >= DATE '1970-01-01';

CREATE INDEX idx_pessoa_nascimento ON pessoa (nascimento);


 exericio 3
DROP INDEX IF EXISTS idx_pessoa_nascimento;

EXPLAIN ANALYZE
SELECT *
FROM pessoa
WHERE nascimento >= DATE '2000-01-01'
AND nome = 'Ana Silva';


CREATE INDEX idx_pessoa_nascimento_nome ON pessoa (nascimento, nome);

EXPLAIN ANALYZE
SELECT * FROM pessoa
WHERE nome = 'Ana Silva';


exercicio 4

DROP INDEX IF EXISTS idx_pessoa_nascimento_nome;
DROP INDEX IF EXISTS idx_pessoa_nome;


CREATE INDEX idx_pessoa_nascimento ON pessoa (nascimento);
CREATE INDEX idx_pessoa_nome ON pessoa (nome);


EXPLAIN ANALYZE
SELECT *
FROM pessoa
WHERE nascimento >= DATE '2000-01-01'
AND nome = 'Ana Silva';

exercicio 5

DROP INDEX IF EXISTS idx_pessoa_nome;
DROP INDEX IF EXISTS idx_pessoa_nascimento;


EXPLAIN ANALYZE
SELECT *
FROM carro
WHERE ano BETWEEN 2015 AND 2020;


CREATE INDEX idx_carro_ano ON carro (ano);


exercicio 6


EXPLAIN ANALYZE
SELECT p.nome, c.placa
FROM pessoa p
JOIN carro c ON p.id_pessoa = c.id_pessoa
WHERE p.nome = 'Ana Silva';

CREATE INDEX idx_pessoa_nome ON pessoa (nome);

CREATE INDEX idx_carro_id_pessoa ON carro (id_pessoa);


exercicio 7

EXPLAIN ANALYZE
SELECT p.nome, c.placa, c.ano
FROM pessoa p
JOIN carro c ON p.id_pessoa = c.id_pessoa
WHERE p.nascimento >= DATE '1980-01-01'
AND c.ano >= 2018;


DROP INDEX IF EXISTS idx_pessoa_nascimento_id;
DROP INDEX IF EXISTS idx_carro_ano_id;

CREATE INDEX idx_pessoa_nascimento_id ON pessoa (nascimento, id_pessoa);
CREATE INDEX idx_carro_ano_id ON carro (ano, id_pessoa);




exericio 8 


DROP INDEX IF EXISTS idx_pessoa_nascimento_id;
DROP INDEX IF EXISTS idx_carro_ano_id;


EXPLAIN ANALYZE
SELECT *
FROM pessoa
WHERE nascimento BETWEEN DATE '1980-01-01' AND DATE '1990-12-31';


CREATE EXTENSION IF NOT EXISTS btree_gist;
CREATE INDEX idx_pessoa_nascimento_gist ON pessoa USING GIST (nascimento);