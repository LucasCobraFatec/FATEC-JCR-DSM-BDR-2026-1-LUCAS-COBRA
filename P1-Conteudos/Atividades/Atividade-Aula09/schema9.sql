EXERCICIO 1

SELECT E.titulo AS "Título do Evento", T.nome AS "Tipo de Evento"
FROM Evento E INNER JOIN TipoEvento T ON E.idTipoEvento = T.idTipoEvento;

EXERCICIO 2

SELECT E.titulo AS "Título do Evento", L.cidade AS "Cidade", L.estado AS "Sigla"
FROM Evento E INNER JOIN Localizacao L ON E.idLocalizacao = L.idLocalizacao;


EXERCICIO 3


SELECT E.titulo AS "Evento", T.nome AS "Tipo", L.cidade AS "Cidade" 
FROM Evento E INNER JOIN TipoEvento T ON E.idTipoEvento = T.idTipoEvento
LEFT JOIN Localizacao L ON E.idLocalizacao = L.idLocalizacao;

EXERCICIO 4

SELECT E.titulo AS "Título do Evento", L.cidade AS "Cidade", L.estado AS "Sigla"
FROM Localizacao L 
RIGHT JOIN Evento E ON L.idLocalizacao = E.idLocalizacao;


FROM Evento LEFT JOIN Localizacao : foca nos Eventos (que é o que me importa agora) e, se tiver uma Localização pra eles, traz também.
FROM Localizacao RIGHT JOIN Evento :o que manda mesmo são os Eventos que estão ali na direita, localizaçao em secundario , entao nao faz sentido a busca devido a legebilidade

EXERCICIO 5

SELECT L.cidade AS "Cidade", COUNT(E.idEvento) AS "Total de Eventos" FROM Localizacao L
INNER JOIN Evento E ON L.idLocalizacao = E.idLocalizacao GROUP BY L.cidade;