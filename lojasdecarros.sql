-- 1️⃣ Criar o banco de dados
DROP DATABASE IF EXISTS LojaCarros;
CREATE DATABASE LojaCarros;
USE LojaCarros;

-- 2️⃣ Tabela Clientes
CREATE TABLE Clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(15),
    endereco VARCHAR(255)
);

-- 3️⃣ Tabela Carros
CREATE TABLE Carros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    modelo VARCHAR(100) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    ano INT NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    disponivel BOOLEAN DEFAULT TRUE
);

-- 4️⃣ Tabela Vendas
CREATE TABLE Vendas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_carro INT NOT NULL,
    data_venda DATETIME DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id),
    FOREIGN KEY (id_carro) REFERENCES Carros(id)
);

-- 5️⃣ Inserir dados de teste em Clientes
INSERT INTO Clientes (nome, cpf, email, telefone, endereco) VALUES
('João Gabriel', '12345678901', 'joao@gmail.com', '11999999999', 'Rua A, 123'),
('Maria Silva', '98765432100', 'maria@gmail.com', '11988888888', 'Rua B, 456'),
('Carlos Pereira', '11122233344', 'carlos@gmail.com', '11977777777', 'Rua C, 789');

-- 6️⃣ Inserir dados de teste em Carros
INSERT INTO Carros (modelo, marca, ano, preco) VALUES
('Civic', 'Honda', 2020, 95000.00),
('Corolla', 'Toyota', 2019, 90000.00),
('Gol', 'Volkswagen', 2021, 70000.00),
('Uno', 'Fiat', 2018, 40000.00),
('Ka', 'Ford', 2022, 65000.00);

-- 7️⃣ Inserir dados de teste em Vendas
INSERT INTO Vendas (id_cliente, id_carro, valor_total) VALUES
(1, 2, 90000.00),
(2, 3, 70000.00);

-- 8️⃣ Consultas úteis

-- Buscar cliente por CPF
SELECT * FROM Clientes WHERE cpf = '12345678901';

-- Buscar carro por ID
SELECT * FROM Carros WHERE id = 1;

-- Listar carros disponíveis
SELECT * FROM Carros WHERE disponivel = TRUE;

-- Registrar uma venda e atualizar disponibilidade
-- Exemplo: cliente 3 compra carro 4
INSERT INTO Vendas (id_cliente, id_carro, valor_total)
VALUES (3, 4, 40000.00);

UPDATE Carros SET disponivel = FALSE WHERE id = 4;

-- Listar todas as vendas com informações do cliente e carro
SELECT v.id, c.nome AS cliente, ca.modelo AS carro, v.data_venda, v.valor_total
FROM Vendas v
JOIN Clientes c ON v.id_cliente = c.id
JOIN Carros ca ON v.id_carro = ca.id;

-- Atualizar informações do cliente
UPDATE Clientes SET telefone = '11966666666' WHERE id = 2;

-- Remover um cliente
DELETE FROM Clientes WHERE id = 3;

-- Remover um carro
DELETE FROM Carros WHERE id = 5;
