DROP DATABASE IF EXISTS biblioteca;
CREATE DATABASE IF NOT EXISTS biblioteca;
use biblioteca;

/* Tirandos os livros das prateleiras */
CREATE TABLE tbl_Livros (
    livros_id INT PRIMARY KEY,
    titulo VARCHAR(255),
    autor VARCHAR(255),
    editora VARCHAR(255),
    ano_publicacao INT,
    isbn VARCHAR(13)
);

/* Retirando o pó */
-- 1. Adicione a regra AUTO_INCREMENT para a chave primária remova os dados referentes ao ID dos livros do script de inserção.
ALTER TABLE tbl_livros MODIFY livros_id int auto_increment;

-- 2. Crie uma tabela para 'Autores' e outra para 'Editoras', para separar essas informações. Elas devem conter chaves primárias para gerar relacionamentos.
CREATE TABLE tbl_autores (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome_autor VARCHAR(255)
);

CREATE TABLE tbl_editoras (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome_editora VARCHAR(255)
);

-- 3. Utilizando ALTER TABLE, elimine as colunas 'autor' e 'editora' da tabela 'Livros' e adicione as colunas 'autor_id' e 'editora_id' para fazer a referências como chave estrangeiras das referidas tabelas.
ALTER TABLE tbl_livros CHANGE autor id_autor INT; 
	-- Ou poderia (Drop): ALTER TABLE tbl_livros DROP COLUMN autor; 
	-- E poderia (ADD): ALTER TABLE tbl_livros ADD id_autor INT AFTER isbn;
ALTER TABLE tbl_livros CHANGE editora id_editora INT; 
	-- Ou Poderia: ALTER TABLE tbl_livros DROP COLUMN editora;
	-- E poderia (ADD): ALTER TABLE tbl_livros ADD id_editora INT AFTER id_autor;
    
-- 4. Retire os valores para autores e para as editoras do script inicial e insira-os nas novas tabelas. 
INSERT INTO tbl_autores(nome_autor) VALUES ('John Green'), ('J.K. Rowling'), ('J.R.R. Tolkien'), ('J.D. Salinger'), ('George Orwell'), ('Rick Riordan');
INSERT INTO tbl_editoras(nome_editora) VALUES('Intrínseca'), ('Rocco'), ('Martins Fontes'), ('Little, Brown and Company'), ('Companhia Editora Nacional');

INSERT INTO tbl_livros(titulo, ano_publicacao, isbn, id_autor, id_editora) VALUES 
('A Culpa é das Estrelas', 2012, '9788580573466', 1, 1),
('Harry Potter e a Pedra Filosofal', 1997, '9788532511010', 2, 2),
('O Senhor dos Anéis: A Sociedade do Anel', 1954, '9788533603149', 3, 3),
('The Catcher in the Rye',  1951, '9780316769488', 4, 4),
('1984', 1949, '9788522106169', 5, 5),
('Percy Jackson e o Ladrão de Raios', 2005, '9788598078355', 6, 1);

/* Colocando tudo no lugar */
INSERT INTO tbl_autores(nome_autor) VALUES ('João Guimarães Rosa'), ('Machado de Assis'), ('Graciliano Ramos'), ('Aluísio Azevedo'), ('Mário de Andrade');
INSERT INTO tbl_editoras(nome_editora) VALUES ('Nova Fronteira'), ( 'Companhia das Letras'), ('Martin Claret'), ('Penguin Companhia');

INSERT INTO tbl_livros(titulo, ano_publicacao, isbn, id_autor, id_editora) VALUES 
('Grande Sertão: Veredas', 1956, '9788520923251', 7, 6),
('Memórias Póstumas de Brás Cubas', 1881, '9788535910663', 8, 7),
('Vidas Secas', 1938, '9788572326972', 9, 5),
('O Alienista', 1882, '9788572327429', 8, 8),
('O Cortiço', 1890, '9788579027048', 10, 9),
('Dom Casmurro', 1899, '9788583862093', 8, 9),
('Macunaíma', 1928, '9788503012302', 11, 5);

/* Select com Join */
SELECT book.livros_id AS id, book.titulo, author.nome_autor AS autor, editora.nome_editora as editora, book.ano_publicacao, book.isbn from tbl_livros AS book 
JOIN tbl_autores AS author ON book.id_autor = author.id 
JOIN tbl_editoras AS editora ON book.id_editora = editora.id;