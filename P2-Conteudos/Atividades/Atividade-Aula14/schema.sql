CREATE TABLE Autor (
id_autor SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL
);
INSERT INTO Autor (nome)
VALUES
('J. R. R. Tolkien'),
('Machado de Assis'),
('Clarice Lispector'),
('J.K. Rowling');
CREATE TABLE Livro (
id_livro SERIAL PRIMARY KEY,
titulo VARCHAR(150) NOT NULL,
ano_publicacao INTEGER,
id_autor INTEGER REFERENCES Autor(id_autor),
id_editora INTEGER
);
INSERT INTO Livro (titulo, ano_publicacao, id_autor, id_editora)
VALUES
('O Senhor dos Anéis', 1954, 1, NULL),
('Dom Casmurro', 1899, 2, 2),
('A Hora da Estrela', 1977, 3, 3),
('O Hobbit', 1937, 1, 1);
ALTER TABLE livro ADD COLUMN num_paginas INT;
UPDATE livro SET num_paginas= 1568 WHERE titulo = 'O Senhor dos Anéis';
UPDATE livro SET num_paginas= 208 WHERE titulo = 'Dom Casmurro';
UPDATE livro SET num_paginas= 88 WHERE titulo = 'A Hora da Estrela';
UPDATE livro SET num_paginas= 336 WHERE titulo = 'O Hobbit';




SELECT nome FROM autor 	WHERE EXISTS (	SELECT 1 FROM livro where livro.id_autor = autor.id_autor);


SELECT autor.nome, ROUND(AVG(livro.num_paginas),2) AS media_paginas
FROM autor JOIN livro ON livro.id_autor = autor.id_autor GROUP BY autor.nome;

CREATE VIEW  vw_media_paginas_autor AS
SELECT autor.nome, ROUND(AVG(livro.num_paginas),2) AS media_paginas
FROM autor JOIN livro ON livro.id_autor = autor.id_autor GROUP BY autor.nome;


SELECT *  FROM vw_media_paginas_autor;


CREATE VIEW vw_total_livros_autor AS
SELECT autor.nome,
	COUNT (livro.id_livro) AS total_livros FROM autor
	LEFT JOIN livro ON livro.id_autor = autor.id_autor
	GROUP BY autor.nome;


SELECT * FROM vw_total_livros_autor;




CREATE VIEW vw_maior_livro_autor AS
SELECT autor.nome,
	MAX(livro.num_paginas)AS maior_livro FROM autor
	JOIN livro ON livro.id_autor = autor.id_autor
	GROUP BY autor.nome;

SELECT * FROM vw_maior_livro_autor;
	


exericio 1

CREATE VIEW vw_titulo_numero_paginas AS 
SELECT titulo , num_paginas FROM livro;


SELECT * FROM vw_titulo_numero_paginas;


exericio 2
CREATE VIEW vw_autor_mais_de_1_livro AS
SELECT nome , COUNT(id_livro) FROM autor JOIN livro ON autor.id_autor = livro.id_autor GROUP BY nome HAVING COUNT(id_livro)>1;


SELECT * FROM vw_autor_mais_de_1_livro;

exericio 3

CREATE VIEW vw_media_paginas AS
SELECT titulo FROM livro WHERE num_paginas > (SELECT AVG(num_paginas) from livro);


SELECT * FROM vw_media_paginas;



exericio 4

CREATE VIEW vw_detalhes_livros AS
SELECT autor.nome , titulo , ano_publicacao FROM autor JOIN livro ON autor.id_autor = livro.id_autor;

  SELECT * FROM vw_detalhes_livros;


exericio 5

CREATE VIEW vw_total_maior_num_paginas AS
SELECT autor.nome , COUNT(livro.id_livro), MAX(livro.num_paginas) FROM autor JOIN livro ON autor.id_autor = livro.id_autor  GROUP BY autor.nome;
 
 
 SELECT * FROM vw_total_maior_num_paginas;
