
INSERT INTO Evento (idEvento, titulo, descricao, dataHora, status, idTipoEvento, idLocalizacao)
VALUES (4, 'Alagamento Centro', 'Acúmulo de água na região central após chuva forte.', '2026-03-08 10:00:00', 1, 2, 6);


INSERT INTO Evento (idEvento, titulo, descricao, dataHora, status, idTipoEvento, idLocalizacao)
VALUES (5, 'Ventos Fortes Jurema', 'Rajadas de vento causando danos em coberturas.', '2026-03-09 08:30:00', 1, 3, 7);

SELECT * FROM Evento 
ORDER BY dataHora ASC;

SELECT titulo, dataHora, descricao 
FROM Evento 
ORDER BY dataHora DESC 
LIMIT 3;