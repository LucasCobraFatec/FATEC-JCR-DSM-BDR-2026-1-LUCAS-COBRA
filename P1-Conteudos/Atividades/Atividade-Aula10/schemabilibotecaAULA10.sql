EXERCICIO 1 : 
SELECT E.nome AS "Editora", 
COUNT(L.id_livro) AS "Quantidade de Livros"
FROM editora E LEFT JOIN livro L ON E.id_editora = L.id_editora
GROUP BY E.nome;

EXERCICIO 2 :

SELECT E.nome AS "Editora", 
COUNT(L.id_livro) AS "Total de Livros"
FROM editora E LEFT JOIN livro L ON E.id_editora = L.id_editora
GROUP BY E.nome;


EXERCICIO 3 :

SELECT A.nome AS "Autor", E.nome AS "Editora", 
COUNT(L.id_livro) AS "Quantidade de Livros"
FROM autor A JOIN livro L ON A.id_autor = L.id_autor
JOIN editora E ON L.id_editora = E.id_editora
GROUP BY A.nome, E.nome ORDER BY A.nome;



EXERCICIO 4 :


SELECT E.nome AS "Editora", COUNT(L.id_livro) AS "Total de Livros"
FROM editora E INNER JOIN livro L ON E.id_editora = L.id_editora
GROUP BY E.nome HAVING COUNT(L.id_livro) > 1;




EXERCICIO 5 : 


SELECT 
    E.nome AS "Editora", 
    COUNT(DISTINCT L.id_livro) AS "Total de Livros", 
    COUNT(EL.id_livro) AS "Total de Empréstimos"
FROM editora E
LEFT JOIN livro L ON E.id_editora = L.id_editora
LEFT JOIN emprestimo_livro EL ON L.id_livro = EL.id_livro
GROUP BY E.nome;