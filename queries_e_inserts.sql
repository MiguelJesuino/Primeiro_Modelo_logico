use ecommerce;

-- Inserir clientes
INSERT INTO clients (Fname, Minit, Lname, CPF, Address, tipo, CNPJ)
VALUES
    ('João', 'A.', 'Silva', '12321378903', 'Rua A, 123', 'PF', NULL),
    ('Empresa XYZ', '', '', NULL, 'Av. B, 456', 'PJ', '1238456151236');
    
-- Inserir produtos
INSERT INTO product (Pname, category, size)
VALUES
    ('Smartphone', 'Eletrônico', '6.2'),
    ('Camiseta', 'Vestimenta', 'M'),
    ('Boneca', 'Brinquedos', NULL);
    
-- Inserir fornecedores
INSERT INTO supplier (SocialName, CNPJ, contact)
VALUES
    ('Fornecedor A', '11111111111112', '9876543210'),
    ('Fornecedor B', '22222222222223', '9876543211');
    
-- Inserir produtos-fornecedores
INSERT INTO productSupplier (idPsSupplier, idPsProduct, quantity)
VALUES
    (1, 1, 100),
    (2, 1, 200),
    (1, 2, 50),
    (2, 2, 100);

-- Inserir pedidos
INSERT INTO orders (idOrderClient, orderDescription)
VALUES
    (1, 'Pedido 1'),
    (1, 'Pedido 2'),
    (2, 'Pedido 3');
    
-- Inserir métodos de pagamento
INSERT INTO payment_methods (methodName)
VALUES
    ('Boleto'),
    ('Cartão de Crédito'),
    ('Transferência');
    

-- Quantos pedidos foram feitos por cada cliente?
SELECT C.idClient, CONCAT(C.Fname, ' ', C.Lname) AS Cliente, COUNT(O.idOrder) AS Quantidade_de_Pedidos
FROM clients C
LEFT JOIN orders O ON C.idClient = O.idOrderClient
GROUP BY C.idClient;

-- Algum vendedor também é fornecedor?
SELECT S.idSeller, S.SocialName AS Nome_Vendedor, S.CNPJ AS CNPJ_Vendedor, F.idSupplier, F.SocialName AS Nome_Fornecedor, F.CNPJ AS CNPJ_Fornecedor
FROM seller S
INNER JOIN productSeller PS ON S.idSeller = PS.idPseller
INNER JOIN productSupplier FS ON PS.idPproduct = FS.idPsProduct
INNER JOIN supplier F ON FS.idPsSupplier = F.idSupplier;

-- Relação de produtos fornecedores e estoques:
SELECT P.Pname AS Produto, F.SocialName AS Fornecedor, PS.quantity AS Estoque
FROM product P
INNER JOIN productSupplier PS ON P.idProduct = PS.idPsProduct
INNER JOIN supplier F ON PS.idPsSupplier = F.idSupplier;