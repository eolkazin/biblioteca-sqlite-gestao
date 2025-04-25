-- Criação das tabelas

DROP TABLE IF EXISTS emprestimos;
DROP TABLE IF EXISTS livros;
DROP TABLE IF EXISTS autores;
DROP TABLE IF EXISTS usuarios;

CREATE TABLE autores (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL
);

CREATE TABLE livros (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL,
    id_autor INTEGER NOT NULL,
    disponivel BOOLEAN DEFAULT 1,
    FOREIGN KEY (id_autor) REFERENCES autores(id)
);

CREATE TABLE usuarios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL
);

CREATE TABLE emprestimos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_livro INTEGER NOT NULL,
    id_usuario INTEGER NOT NULL,
    data_emprestimo DATE NOT NULL,
    data_devolucao DATE,
    FOREIGN KEY (id_livro) REFERENCES livros(id),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

-- Dados iniciais

INSERT INTO autores (nome) VALUES 
('George Orwell'), 
('J.K. Rowling'), 
('Machado de Assis');

INSERT INTO livros (titulo, id_autor) VALUES 
('1984', 1), 
('Harry Potter e a Pedra Filosofal', 2), 
('Dom Casmurro', 3), 
('A Revolução dos Bichos', 1);

INSERT INTO usuarios (nome) VALUES 
('Lucas'), 
('Ana'), 
('João');

-- Empréstimos (Lucas pegou 2 livros)
INSERT INTO emprestimos (id_livro, id_usuario, data_emprestimo) VALUES
(1, 1, DATE('now', '-10 days')),
(2, 1, DATE('now', '-5 days')),
(3, 2, DATE('now', '-2 days'));

-- Devolução de 1 livro
UPDATE emprestimos SET data_devolucao = DATE('now', '-1 day') WHERE id = 1;

-- Atualizar disponibilidade
UPDATE livros SET disponivel = 0 WHERE id IN (
    SELECT id_livro FROM emprestimos WHERE data_devolucao IS NULL
);
