--Exercicio 1 --

CREATE OR REPLACE PROCEDURE inserir_livro_condicao(p_id_autor INT)
LANGUAGE plpgsql
AS $$
BEGIN
	IF NOT EXISTS (SELECT 1 FROM autor WHERE id_autor = p_id_autor) THEN
	RAISE EXCEPTION 'Autor não cadastrado';
END IF;
INSERT INTO 
	livro(titulo,ano_publicacao,id_autor,id_editora,num_paginas)
	VALUES(p_titulo,p_ano,p_id_autor,p_id_editora,p_paginas);
	END;

CALL inserir_livro_condicao('Memórias Póstumas', 1881, 2, 2, 240);
CALL inserir_livro_condicao('Livro Órfão', 2026, 99, NULL, 150);

--Exerciocio 2


CREATE OR REPLACE PROCEDURE atualizar_paginas_att(p_id_livro INT, p_paginas INT)
LANGUAGE plpgsql
AS $$
BEGIN
    
    IF p_paginas <= 10 THEN
        RAISE EXCEPTION 'Só é permitido livros com mais de 10 páginas'; 
    END IF;

  
    UPDATE livro
    SET num_paginas = p_paginas
    WHERE id_livro = p_id_livro;
END;
$$;


CALL atualizar_paginas_att(3, 95); 
CALL atualizar_paginas_att(3, 5); 


--Exercicio 3


CREATE OR REPLACE PROCEDURE exclur_autor_sem_livros(p_id_autor INT)
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM livro WHERE id_autor = p_id_autor) THEN
	RAISE EXCEPTION 'Não é possível excluir o autor pois ele possui livros cadastrados.';
END IF;

	DELETE FROM autor WHERE id_autor = p_id_autor;
END;
$$;

CALL exclur_autor_sem_livros(1);

--Exericio 4

CREATE OR REPLACE FUNCTION obter_media_autor(p_id_autor INT)
RETURNS TABLE (
    nome_autor VARCHAR,
    media_paginas NUMERIC
) 
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY 
    SELECT 
        autor.nome, 
        AVG(livro.num_paginas)
    FROM autor 
    JOIN livro ON autor.id_autor = livro.id_autor
    WHERE autor.id_autor = p_id_autor
    GROUP BY autor.nome;
END;
$$;

SELECT * FROM obter_media_autor(1);



--exericio 5


CREATE OR REPLACE PROCEDURE inserir_livro_5(
    p_titulo VARCHAR,
    p_ano INT,
    p_id_autor INT,
    p_id_editora INT,
    p_paginas INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    
    IF p_titulo IS NULL OR TRIM(p_titulo) = '' THEN
        RAISE EXCEPTION 'Erro: O título do livro não pode ser vazio ou nulo!';
    END IF;

   
    IF p_paginas IS NULL OR p_paginas <= 0 THEN
        RAISE EXCEPTION 'Erro: O número de páginas deve ser maior que zero!';
    END IF;

  
    IF NOT EXISTS (SELECT 1 FROM Autor WHERE id_autor = p_id_autor) THEN
        RAISE EXCEPTION 'Erro: O autor informado (ID %) não existe no sistema!', p_id_autor;
    END IF;

    
    INSERT INTO Livro (titulo, ano_publicacao, id_autor, id_editora, num_paginas)
    VALUES (p_titulo, p_ano, p_id_autor, p_id_editora, p_paginas);
    
END;
$$;

CALL inserir_livro_5('O Silmarillion', 1977, 1, NULL, 365);
CALL inserir_livro_5('', 2026, 1, NULL, 150);
CALL inserir_livro_5('Livro Teste', 2026, 1, NULL, -5);

--exericio 6

CALL inserir_livro_5('O Silmarillion', 1977, 1, NULL, -15);


