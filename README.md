# Projeto de Banco de Dados – E-commerce

## 📌 Descrição do Projeto
Este projeto consiste em um **banco de dados relacional** para um cenário de **e-commerce**, desenvolvido utilizando **MySQL Workbench**.  

O objetivo é aplicar conceitos de **modelagem de dados**, como chaves primárias, estrangeiras, relacionamentos 1:N e N:M, além de criar **queries SQL complexas** para análise de dados de clientes, produtos, pedidos, fornecedores, pagamentos e entregas.

Este projeto foi desenvolvido como parte do curso da Dio, servindo como **exercício prático** de criação e manipulação de banco de dados.

No script.sql você encontrara o código completo que utilizei

---

## 🎯 Objetivos do Projeto
- Criar um **banco de dados lógico** representando um e-commerce realista.  
- Aplicar **relacionamentos entre entidades**, incluindo N:M e 1:N.  
- Inserir **dados de teste** para validação do modelo.  
- Criar **queries SQL complexas** utilizando:  
  - `SELECT`, `WHERE`, `JOIN`, `GROUP BY`, `HAVING`, `ORDER BY`  
  - Atributos derivados, como cálculo de valor total de pedidos  

---

## 🗂️ Modelo Lógico do Banco de Dados

### Entidades Principais:
- **Clientes**: Podem ser Pessoa Física (PF) ou Pessoa Jurídica (PJ). Cada cliente tem nome, CPF/CNPJ e e-mail.  
- **Produtos**: Contêm nome, preço e quantidade em estoque.  
- **Fornecedores**: Informações de nome e e-mail, podendo fornecer vários produtos.  
- **Pedidos**: Cada pedido pertence a um cliente e possui data de realização.  
- **ItensPedido**: Relacionamento N:M entre pedidos e produtos, armazenando quantidade e preço unitário.  
- **Produto_Fornecedor**: Relacionamento N:M entre produtos e fornecedores.  
- **Pagamentos**: Diferentes formas de pagamento cadastradas por cliente.  
- **Entregas**: Status e código de rastreio para cada pedido.  

### Principais Relacionamentos:
| Relacionamento | Tipo |
|----------------|------|
| Cliente → Pedido | 1:N |
| Pedido → Produto | N:M (via ItensPedido) |
| Produto → Fornecedor | N:M (via Produto_Fornecedor) |
| Pedido → Pagamento | 1:N |
| Pedido → Entrega | 1:1 |

---

## 💻 Estrutura das Tabelas

- **Clientes**: `id_cliente`, `nome`, `tipo`, `cpf_cnpj`, `email`  
- **Produtos**: `id_produto`, `nome_produto`, `preco`, `estoque`  
- **Fornecedores**: `id_fornecedor`, `nome_fornecedor`, `email`  
- **Produto_Fornecedor**: `id_produto`, `id_fornecedor`  
- **Pedidos**: `id_pedido`, `id_cliente`, `data_pedido`  
- **ItensPedido**: `id_pedido`, `id_produto`, `quantidade`, `preco_unitario`  
- **Pagamentos**: `id_pagamento`, `id_cliente`, `forma_pagamento`  
- **Entregas**: `id_entrega`, `id_pedido`, `status`, `codigo_rastreio`  

---

## 🔧 Queries de Exemplo

### 1. Recuperação simples
```sql
SELECT * FROM Clientes;
````

### 2. Filtro de clientes por tipo

```sql
SELECT nome, email FROM Clientes WHERE tipo='PF';
```

### 3. Valor total de cada pedido

```sql
SELECT id_pedido, SUM(quantidade * preco_unitario) AS valor_total
FROM ItensPedido
GROUP BY id_pedido;
```

### 4. Produtos ordenados por preço

```sql
SELECT nome_produto, preco FROM Produtos ORDER BY preco DESC;
```

### 5. Clientes com mais de um pedido

```sql
SELECT c.nome, COUNT(p.id_pedido) AS total_pedidos
FROM Clientes c
JOIN Pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente
HAVING total_pedidos > 1;
```

### 6. Produtos e seus fornecedores

```sql
SELECT p.nome_produto, f.nome_fornecedor, p.estoque
FROM Produtos p
JOIN Produto_Fornecedor pf ON p.id_produto = pf.id_produto
JOIN Fornecedores f ON pf.id_fornecedor = f.id_fornecedor;
```

### 7. Produtos com estoque abaixo de 20

```sql
SELECT nome_produto, estoque 
FROM Produtos
WHERE estoque < 20;
```

---

## 🚀 Aprendendo Como Executar o Projeto

1. Abra o **MySQL Workbench** e conecte-se ao seu servidor local.
2. Crie uma nova conexão ou use a existente (`localhost`).
3. Copie e cole o **script SQL completo** do projeto no editor SQL.
4. Execute o script para criar o banco de dados, tabelas e inserir dados de teste.
5. Execute as queries para explorar os dados e validar os relacionamentos.

---

## 📊 Benefícios deste Projeto

* Prática de **modelagem conceitual e lógica** de banco de dados.
* Aprendizado em **SQL avançado** (joins, agregações, filtros, HAVING).
* Preparação para projetos reais de **e-commerce** e análise de dados.

---
