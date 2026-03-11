DROP TABLE IF EXISTS Alerta CASCADE;
DROP TABLE IF EXISTS Relato CASCADE;
DROP TABLE IF EXISTS Evento CASCADE;
DROP TABLE IF EXISTS StatusEvento CASCADE;
DROP TABLE IF EXISTS Usuario CASCADE;
DROP TABLE IF EXISTS Localizacao CASCADE;
DROP TABLE IF EXISTS TipoEvento CASCADE;
CREATE TABLE TipoEvento (
idTipoEvento SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
descricao TEXT
);
CREATE TABLE Localizacao (
idLocalizacao SERIAL PRIMARY KEY,
latitude DECIMAL(9,6) NOT NULL,
longitude DECIMAL(9,6) NOT NULL,
cidade VARCHAR(100),
estado CHAR(2)
);
CREATE TABLE Usuario (
idUsuario SERIAL PRIMARY KEY,
nome VARCHAR(150) NOT NULL,
email VARCHAR(150) UNIQUE NOT NULL,
senhaHash TEXT NOT NULL
);
CREATE TABLE StatusEvento(
idStatusevento SERIAL PRIMARY KEY,
status VARCHAR(50) CHECK (status IN ('Ativo', 'Em Monitoramento', 'Resolvido'))
);
CREATE TABLE Evento (
idEvento SERIAL PRIMARY KEY,
titulo VARCHAR(200) NOT NULL,
descricao TEXT,
dataHora TIMESTAMP NOT NULL,
status INTEGER REFERENCES StatusEvento(idStatusevento),
idTipoEvento INTEGER REFERENCES TipoEvento(idTipoEvento),
idLocalizacao INTEGER REFERENCES Localizacao(idLocalizacao)
);
CREATE TABLE Relato (
idRelato SERIAL PRIMARY KEY,
texto TEXT NOT NULL,
dataHora TIMESTAMP NOT NULL,
idEvento INTEGER REFERENCES Evento(idEvento),
idUsuario INTEGER REFERENCES Usuario(idUsuario)
);
CREATE TABLE Alerta (
idAlerta SERIAL PRIMARY KEY,
mensagem TEXT NOT NULL,
dataHora TIMESTAMP NOT NULL,
nivel VARCHAR(20) CHECK (nivel IN ('Baixo', 'Médio', 'Alto', 'Crítico')),
idEvento INTEGER REFERENCES Evento(idEvento)
);
INSERT INTO StatusEvento (idStatusevento, status) VALUES (1, 'Ativo'), (2, 'Em Monitoramento'), (3, 'Resolvido');

INSERT INTO TipoEvento (idTipoEvento, nome, descricao)
VALUES (1, 'Queimada', 'Incêndio de grandes proporções em áreas urbanas ou rurais.'),
(2, 'Alagamento', 'Chuva muito forte alagando ruas e estradas'),
(3, 'Furacao', 'Ventos muito fortes derrubando arvores e construções');
INSERT INTO Localizacao (idLocalizacao, latitude, longitude, cidade, estado)
VALUES (5, -23.305, -45.965, 'Jacareí', 'SP'),
(6,-23.0258,-45.5586,'Taubate', 'SP'),
(7,-23.1900,-45.8846,'São José dos Campos', 'SP');
INSERT INTO Usuario (idUsuario, nome, email, senhaHash)
VALUES (2, 'Maria Oliveira', 'maria.oliveira@email.com', '2b6c7f64f76b09d0a7b9e...'),
(3, 'Juca da Silva', 'Jucas@email.com', '2dsds4f76b09d0a7b9e...'),
(4, 'Leonardo Correia', 'Leonardo@email.com', '000sdf64f76b09d0a7b9e...');
INSERT INTO Evento (idEvento, titulo, descricao, dataHora, status, idTipoEvento, idLocalizacao)
VALUES (1, 'Queimada em área de preservação', 'Fogo se alastrando na mata próxima à represa.', '2025-08-15 14:35:00', 1, 1, 5),
(2, 'Alagamento em area Residêncial', 'Devido a problemas de escoamento e forte chuva constante, varias areas estao alagadas.', '2025-03-02 19:35:00', 2, 2, 6),
(3, 'Furacão na região', 'Ventos fortes destruindo estruturas e arvores em toda região', '2026-01-20 14:35:00', 1, 3, 7);
INSERT INTO Relato (texto, dataHora, idEvento, idUsuario)
VALUES ('Fumaça intensa e chamas visíveis a partir da rodovia.', '2025-08-15 15:10:00', 1, 2),
('Ruas e avenidas alagadas', '2025-03-02 16:35:00', 2, 3),
('Vento esta destruindo torres e levando arvores', '2026-01-20 14:35:00', 3, 4);
INSERT INTO Alerta (mensagem, dataHora, nivel, idEvento)
VALUES ('Evacuação imediata da área próxima à represa.', '2025-08-15 15:20:00', 'Crítico', 1),
('Evacuação das pessoas com casas que foram alagadas.', '2025-03-02 20:35:00', 'Crítico', 2),
('Evacuação imediata dos locais destruido pelo furacão.', '2026-01-20 19:35:00', 'Crítico', 3);

INSERT INTO Evento (idEvento, titulo, descricao, dataHora, status, idTipoEvento, idLocalizacao)
VALUES (4, 'Alagamento Centro', 'Acúmulo de água na região central após chuva forte.', '2026-03-08 10:00:00', 1, 2, 6);
INSERT INTO Evento (idEvento, titulo, descricao, dataHora, status, idTipoEvento, idLocalizacao)
VALUES (5, 'Ventos Fortes Jurema', 'Rajadas de vento causando danos em coberturas.', '2026-03-09 08:30:00', 1, 3, 7);