-- =========================================
-- Projeto de E-commerce
-- =========================================

-- 1. Criação do banco de dados
CREATE DATABASE IF NOT EXISTS Ecommerce;
USE Ecommerce;

-- 2. Tabelas principais

-- Clientes (PF ou PJ)
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo ENUM('PF','PJ') NOT NULL,
    cpf_cnpj VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE
);

-- Produtos
CREATE TABLE Produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL
);

-- Fornecedores
CREATE TABLE Fornecedores (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    nome_fornecedor VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);

-- Produto ↔ Fornecedor (N:M)
CREATE TABLE Produto_Fornecedor (
    id_produto INT,
    id_fornecedor INT,
    PRIMARY KEY (id_produto, id_fornecedor),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto),
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedores(id_fornecedor)
);

-- Pedidos
CREATE TABLE Pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Itens do Pedido (Pedido ↔ Produto N:M)
CREATE TABLE ItensPedido (
    id_pedido INT,
    id_produto INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);

-- Pagamentos (um cliente pode ter várias formas)
CREATE TABLE Pagamentos (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    forma_pagamento VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Entregas (cada pedido tem status e código de rastreio)
CREATE TABLE Entregas (
    id_entrega INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    status VARCHAR(50),
    codigo_rastreio VARCHAR(50),
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido)
);

-- =========================================
-- 3. Inserção de dados de teste
-- =========================================

-- Clientes
INSERT INTO Clientes (nome, tipo, cpf_cnpj, email) VALUES
('Lucas Gabriel', 'PF', '12345678901', 'lucas@email.com'),
('Empresa XYZ', 'PJ', '98765432000100', 'contato@empresa.com');

-- Produtos
INSERT INTO Produtos (nome_produto, preco, estoque) VALUES
('Notebook', 3500.00, 10),
('Mouse', 150.00, 50),
('Teclado', 200.00, 30),
('Monitor', 1200.00, 20);

-- Fornecedores
INSERT INTO Fornecedores (nome_fornecedor, email) VALUES
('Fornecedor A', 'fornecedorA@email.com'),
('Fornecedor B', 'fornecedorB@email.com'),
('Fornecedor C', 'fornecedorC@email.com');

-- Produto_Fornecedor
INSERT INTO Produto_Fornecedor VALUES
(1,1),
(2,2),
(3,2),
(4,3);

-- Pedidos
INSERT INTO Pedidos (id_cliente, data_pedido) VALUES
(1,'2025-09-06'),
(2,'2025-09-06');

-- ItensPedido
INSERT INTO ItensPedido VALUES
(1,1,1,3500.00),
(1,2,2,150.00),
(2,3,1,200.00),
(2,4,2,1200.00);

-- Pagamentos
INSERT INTO Pagamentos (id_cliente, forma_pagamento) VALUES
(1,'Cartão de Crédito'),
(1,'Boleto'),
(2,'Transferência'),
(2,'Cartão de Crédito');

-- Entregas
INSERT INTO Entregas (id_pedido, status, codigo_rastreio) VALUES
(1,'Em transporte','ABC123456'),
(2,'Entregue','XYZ987654');

-- =========================================
-- 4. Queries complexas
-- =========================================

-- 4.1 Recuperação simples
SELECT * FROM Clientes;

-- 4.2 Filtro com WHERE
SELECT nome, email FROM Clientes WHERE tipo='PF';

-- 4.3 Atributos derivados (total do pedido)
SELECT id_pedido, SUM(quantidade * preco_unitario) AS valor_total
FROM ItensPedido
GROUP BY id_pedido;

-- 4.4 Ordenação
SELECT nome_produto, preco FROM Produtos ORDER BY preco DESC;

-- 4.5 Condição de filtros aos grupos (HAVING)
SELECT id_cliente, COUNT(id_pedido) AS total_pedidos
FROM Pedidos
GROUP BY id_cliente
HAVING total_pedidos > 0;

-- 4.6 Junção entre tabelas (produtos e fornecedores)
SELECT p.nome_produto, f.nome_fornecedor
FROM Produtos p
JOIN Produto_Fornecedor pf ON p.id_produto = pf.id_produto
JOIN Fornecedores f ON pf.id_fornecedor = f.id_fornecedor;

-- 4.7 Quantos pedidos foram feitos por cada cliente
SELECT c.nome, COUNT(p.id_pedido) AS total_pedidos
FROM Clientes c
LEFT JOIN Pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente;

-- 4.8 Relacionar produtos, fornecedores e estoque
SELECT p.nome_produto, f.nome_fornecedor, p.estoque
FROM Produtos p
JOIN Produto_Fornecedor pf ON p.id_produto = pf.id_produto
JOIN Fornecedores f ON pf.id_fornecedor = f.id_fornecedor
ORDER BY p.estoque DESC;

-- 4.9 Verificar se algum vendedor também é fornecedor (exemplo fictício)
-- Supondo que Cliente pode ser vendedor
SELECT c.nome AS cliente_vendedor, f.nome_fornecedor
FROM Clientes c
JOIN Fornecedores f ON c.nome = f.nome_fornecedor;

