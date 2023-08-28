create database ecommerce;

use ecommerce;

create table clients(
		idClient int auto_increment primary key,
        Fname varchar(10),
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
        Address varchar(255),
        constraint unique_cpf_client unique (CPF)
);

alter table clients auto_increment=1;
ALTER TABLE clients MODIFY COLUMN Fname varchar(50);


ALTER TABLE clients
ADD COLUMN tipo ENUM('PF', 'PJ') NOT NULL AFTER idClient;

ALTER TABLE clients
DROP COLUMN CPF;

ALTER TABLE clients
ADD COLUMN CPF CHAR(11) AFTER tipo;

ALTER TABLE clients
ADD COLUMN CNPJ CHAR(14) AFTER CPF;

ALTER TABLE clients
ADD CONSTRAINT cpf_cliente_unico UNIQUE (CPF),
ADD CONSTRAINT cnpj_cliente_unico UNIQUE (CNPJ),
ADD CHECK ((tipo = 'PF' AND CPF IS NOT NULL AND CNPJ IS NULL) OR (tipo = 'PJ' AND CNPJ IS NOT NULL AND CPF IS NULL));

CREATE TABLE clientes_individuais(
    idCliente INT PRIMARY KEY,
    dataNascimento DATE,
    genero ENUM('M', 'F', 'Outro')
);

CREATE TABLE clientes_pj(
    idCliente INT PRIMARY KEY,
    nomeEmpresa VARCHAR(100),
    dataRegistro DATE
);


create table product(
		idProduct int auto_increment primary key,
        Pname varchar(255) not null,
        classification_kids bool default false,
        category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
        avaliação float default 0,
        size varchar(10)
);

alter table product auto_increment=1;

create table payments(
	idclient int,
    idPayment int,
    typePayment enum('Boleto','Cartão','Dois cartões'),
    limitAvailable float,
    primary key(idClient, idPayment)
);

create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash boolean default false, 
    constraint fk_ordes_client foreign key (idOrderClient) references clients(idClient)
			on update cascade
);

alter table orders auto_increment=1;
desc orders;

create table payment_methods(
    idPaymentMethod int auto_increment primary key,
    methodName varchar(50) not null
);

ALTER TABLE orders
ADD COLUMN paymentMethodID INT;

create table order_payment_methods(
    idOrder int,
    idPaymentMethod int,
    primary key (idOrder, idPaymentMethod),
    constraint fk_order_payment_order foreign key (idOrder) references orders(idOrder),
    constraint fk_order_payment_method foreign key (idPaymentMethod) references payment_methods(idPaymentMethod)
);


create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);
alter table productStorage auto_increment=1;

create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);
alter table supplier auto_increment=1;

desc supplier;

create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(15),
    CPF char(9),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);

alter table seller auto_increment=1;


create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

desc productSeller;

create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_product foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_order foreign key (idPOorder) references orders(idOrder)

);

create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_prodcut foreign key (idPsProduct) references product(idProduct)
);

desc productSupplier;

show tables;

show databases;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';