CREATE DATABASE SIMPOSIO; 

USE SIMPOSIO;

CREATE TABLE PESSOA (
    ID_PESSOA INT AUTO_INCREMENT PRIMARY KEY,
    NOME_PESSOA VARCHAR(100),
    EMAIL_PESSOA VARCHAR(100),
    TIPO_PESSOA ENUM('Participante', 'Autor','Organizador', 'Mini-Curso') NOT NULL
);

CREATE TABLE SIMPOSIO (
    ID_SIMPOSIO INT AUTO_INCREMENT PRIMARY KEY,
    NOME_SIMPOSIO VARCHAR(100) NOT NULL,
    `DATA_SIMPOSIO` DATE,
    `LOCAL_SIMPOSIO` VARCHAR(100)
);

CREATE TABLE TEMA (
    ID_TEMA INT AUTO_INCREMENT PRIMARY KEY,
    NOME_TEMA VARCHAR(100) NOT NULL
);

CREATE TABLE MINI_CURSO (
    ID_MINI_CURSO INT AUTO_INCREMENT PRIMARY KEY,
    NOME_MINI_CURSO VARCHAR(100) NOT NULL,
    DESC_MINI_CURSO TEXT,
    ID_RESPONSAVEL INT,
    FOREIGN KEY (ID_RESPONSAVEL) REFERENCES PESSOA(ID_PESSOA)
);

CREATE TABLE COMISSAO (
    ID_COMISSAO INT AUTO_INCREMENT PRIMARY KEY,
    NOME_COMISSAO VARCHAR(100) NOT NULL,
    ID_TEMA_COMISSAO INT,
    FOREIGN KEY (ID_TEMA_COMISSAO) REFERENCES TEMA(ID_TEMA)
);

CREATE TABLE ARTIGO (
    ID_ARTIGO INT AUTO_INCREMENT PRIMARY KEY,
    TITULO VARCHAR(200),
    DESCRICAO TEXT,
    ID_TEMA_ARTIGO INT,
    FOREIGN KEY (ID_TEMA_ARTIGO) REFERENCES TEMA(ID_TEMA)
);

CREATE TABLE PARECER (
    ID_PARECER INT AUTO_INCREMENT PRIMARY KEY,
    DESC_PARECER TEXT,
    ID_COMISSAO_PARECER INT,
    ID_ARTIGO_PARECER INT,
    FOREIGN KEY (ID_COMISSAO_PARECER) REFERENCES COMISSAO(ID_COMISSAO),
    FOREIGN KEY (ID_ARTIGO_PARECER) REFERENCES ARTIGO(ID_ARTIGO)
);

CREATE TABLE INSCRICAO (
    ID_INSCRICAO INT AUTO_INCREMENT PRIMARY KEY,
    ID_PESSOA_INSCRICAO INT,
    ID_SIMPOSIO_INSCRICAO INT,
    TIPO_INSCRICAO ENUM('Mini-Curso', 'Palestra'),
    FOREIGN KEY (ID_PESSOA_INSCRICAO) REFERENCES PESSOA(ID_PESSOA),
    FOREIGN KEY (ID_SIMPOSIO_INSCRICAO) REFERENCES SIMPOSIO(ID_SIMPOSIO)
);
-- Esqueci de adicionar as pessoas da tabela Artigo e Mini_curso (pesquisei) 
ALTER TABLE ARTIGO
ADD COLUMN ID_PESSOA_ARTIGO INT,
ADD FOREIGN KEY (ID_PESSOA_ARTIGO) REFERENCES PESSOA(ID_PESSOA);

ALTER TABLE MINI_CURSO
ADD COLUMN ID_PESSOA_MINICURSO INT,
ADD FOREIGN KEY (ID_PESSOA_MINICURSO) REFERENCES PESSOA(ID_PESSOA);

-- Adicionando Dados nas tabelas 

INSERT INTO PESSOA (NOME_PESSOA, EMAIL_PESSOA, TIPO_PESSOA) VALUES
('Lucas Almeida', 'rafael.oliveira@email.com', 'Participante'),
('Fernanda Souza', ' fernanda.souza@email.com', 'Mini-Curso'),
('Carlos Pereira', ' carlos.pereira@email.com', 'Autor'),
('Rafael Oliveira', 'maria.costa@email.com', 'Autor'),
('Mariana Costa', ' mariana.costa@email.com', 'Organizador');

INSERT INTO SIMPOSIO (NOME_SIMPOSIO, `DATA_SIMPOSIO`, `LOCAL_SIMPOSIO`) VALUES
('Simpósio de Tecnologia 2025', '2025-04-08', 'Auditório Unoesc Videira');

INSERT INTO TEMA (NOME_TEMA) VALUES
('Banco de Dados'),
('Redes'),
('Compiladores'),
('Realidade Virtual');

INSERT INTO MINI_CURSO (NOME_MINI_CURSO, DESC_MINI_CURSO, ID_RESPONSAVEL) VALUES
('Redes e Segurança em Computação', 'Este mini-curso aborda os principais conceitos de Redes e Segurança em Computação.', 2),
('Inteligência Artificial e Machine Learning', 'Este mini-curso aborda os principais conceitos de Inteligência Artificial e Machine Learning.', 2);

INSERT INTO COMISSAO (NOME_COMISSAO, ID_TEMA_COMISSAO) VALUES
('Comissão de Banco de Dados', 1),
('Comissão de Redes', 2);

INSERT INTO ARTIGO (TITULO, DESCRICAO, ID_TEMA_ARTIGO) VALUES
('Análise de Compiladores', 'Artigo sobre o impacto dos Compiladores no desenvolvimento de software.', 1),
('Redes de Alta Velocidade (5G)', 'Artigo sobre os desafios e oportunidades das redes 5G.', 2);

INSERT INTO PARECER (DESC_PARECER, ID_COMISSAO_PARECER, ID_ARTIGO_PARECER) VALUES
('O artigo está bem escrito e aborda de forma relevante os temas dos Compiladores.', 1, 1),
('O artigo possui boas análises sobre redes de alta velocidade, com contribuições relevantes nos avanços de sinais 5G.', 2, 2);

INSERT INTO INSCRICAO (ID_PESSOA_INSCRICAO, ID_SIMPOSIO_INSCRICAO, TIPO_INSCRICAO) VALUES
(5, 1, 'Mini-Curso'),
(4, 1, 'Palestra'),
(3, 1, 'Palestra');