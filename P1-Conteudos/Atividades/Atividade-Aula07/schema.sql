1:
SELECT COUNT(*) AS total_usuarios FROM Usuario;

2:
SELECT idTipoEvento, COUNT(*) AS total_eventos FROM Evento GROUP BY idTipoEvento;


3:
SELECT MIN(dataHora) AS evento_mais_antigo, MAX(dataHora) AS evento_mais_recente FROM Evento;


4: 
SELECT(SELECT COUNT(*) FROM Evento) * 1.0 / (SELECT COUNT(DISTINCT cidade) FROM Localizacao) AS media_eventos_por_cidade;