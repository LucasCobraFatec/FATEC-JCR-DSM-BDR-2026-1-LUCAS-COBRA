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


exercicio 1

SELECT a.nome,
(SELECT COUNT(*) FROM Livro l WHERE l.id_autor = a.id_autor) AS total_livros,
(SELECT AVG(num_paginas) FROM Livro l WHERE l.id_autor = a.id_autor) AS
media_paginas
FROM Autor a;
WITH ResumoLivros AS ( SELECT id_autor,
COUNT(*) AS total_livros, AVG(num_paginas) AS media_paginas
FROM Livro GROUP BY id_autor
)
SELECT a.nome,
COALESCE(r.total_livros, 0) AS total_livros,
COALESCE(r.media_paginas, 0) AS media_paginas
FROM Autor a LEFT JOIN ResumoLivros r ON a.id_autor = r.id_autor;


exercicio 2

WITH paginas_por_autor AS ( SELECT id_autor, SUM(num_paginas) AS soma_total
FROM Livro GROUP BY id_autor)
SELECT a.nome, p.soma_total
FROM Autor a JOIN paginas_por_autor p ON a.id_autor = p.id_autor
WHERE p.soma_total > (SELECT AVG(num_paginas) FROM Livro);


exercicio 3

SELECT a.nome,
(SELECT COUNT(*)
FROM Livro l WHERE l.id_autor = a.id_autor) AS total_livros FROM Autor a;
WITH contagem_cte AS (
SELECT id_autor, COUNT(*) AS total
FROM Livro
GROUP BY id_autor
)
SELECT a.nome,
COALESCE(c.total, 0) AS total_livros
FROM Autor a LEFT JOIN contagem_cte c ON a.id_autor = c.id_autor;


