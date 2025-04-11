-- Criação do Banco de Dados
CREATE DATABASE oficina;

-- Usar o Banco de Dados
USE oficina;

-- Tabela Cliente
CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY,
    Nome VARCHAR(45),
    CPF VARCHAR(45)
);

-- Tabela Veiculos
CREATE TABLE Veiculos (
    idVeiculos INT PRIMARY KEY,
    Modelo VARCHAR(45),
    Marca VARCHAR(45),
    idClienteVec INT,
    FOREIGN KEY (idClienteVec) REFERENCES Cliente(idCliente)
);
drop table Veiculos;
-- Tabela Equipe/Mecanicos
CREATE TABLE EquipeMecanicos (
    idMecanicos INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(45) NOT NULL,
    Endereco VARCHAR(45),
    Codigo VARCHAR(45),
    Especialidade VARCHAR(45),
    idVeiculosMEC INT,
    FOREIGN KEY (idVeiculosMEC) REFERENCES Veiculos(idVeiculos)
);
select * from EquipeMecanicos;

-- Tabela de Junção Mecanicos_Identifica_Servico
CREATE TABLE MecanicosIdentificaServico (
	idMecanicos_ident INT,
	idServicos_ident INT,
    PRIMARY KEY (idMecanicos_ident, idServicos_ident),
    FOREIGN KEY (idMecanicos_ident) REFERENCES EquipeMecanicos(idMecanicos),
    FOREIGN KEY (idServicos_ident) REFERENCES Servicos(idServicos)
);
-- Tabela de Junção Cliente_Autoriza_Servico
CREATE TABLE ClienteAutorizaServico (
    idClienteAutoriza INT,
    idServicosAutoriza INT,
    PRIMARY KEY (idClienteAutoriza, idServicosAutoriza),
    FOREIGN KEY (idClienteAutoriza) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idServicosAutoriza) REFERENCES Servicos(idServicos)
);
-- Tabela Servicos
CREATE TABLE Servicos (
    idServicos INT PRIMARY KEY,
    Conserto VARCHAR(45),
    Revisao VARCHAR(45),
    Orcamento_pagamento int,
	FOREIGN KEY (Orcamento_pagamento) REFERENCES Orcamento(idPagamento)
);
-- Tabela OS (Ordem de Serviço)
CREATE TABLE OS (
	idOS INT PRIMARY KEY AUTO_INCREMENT,
    Número VARCHAR(45),
    Data_de_emissão DATETIME,
    Status VARCHAR(45),
    Data_conclusão VARCHAR(45),
    Pecas VARCHAR(45),
    Referencia_de_mão_de_obra VARCHAR(45),
    IdMecanicosOS INT,
    FOREIGN KEY (IdMecanicosOS) REFERENCES EquipeMecanicos(idMecanicos)
); 
    alter table OS rename column peças to pecas;
desc OS;

ALTER TABLE OS
DROP COLUMN IdVeiculosOS;

-- Tabela Valores de Referencia
CREATE TABLE ValoresReferencia (
    idReferenciaDeMaoDeObra INT PRIMARY KEY,
    ValoresServico decimal(10,2)
);
 -- Tabela de Junção OS_has_Pecas
CREATE TABLE OSHasPecas (
    OS_idOS INT,
    Pecas_idPecas INT,
    PRIMARY KEY (OS_idOS, Pecas_idPecas),
    FOREIGN KEY (OS_idOS) REFERENCES OS(idOS),
    FOREIGN KEY (Pecas_idPecas) REFERENCES Pecas(idPecas)
);
-- Tabela Pecas
CREATE TABLE Pecas (
    idPecas INT PRIMARY KEY,
    NomeP varchar(45),
    Valores decimal(10,2)
);
alter table pecas change column Valores Valores decimal(10,2);

-- Tabela Orçamento
CREATE TABLE Orcamento (
    idPagamento INT PRIMARY KEY AUTO_INCREMENT
);
-- Tabela Orçamento_has_Peças
CREATE TABLE Orcamento_has_Pecas (
    idPagamentoORC INT,
    idPecasORC INT,
    PRIMARY KEY (idPagamentoORC, idPecasORC),
    FOREIGN KEY (idPagamentoORC) REFERENCES Orcamento(idPagamento),
    FOREIGN KEY (idPecasORC) REFERENCES Pecas(idPecas)
);

CREATE TABLE Valores_referencia_has_Orçamento (
    Valores_referencia_idReferencia_mao_de_obra INT,
    Orcamento_idPagamento INT,
    PRIMARY KEY (Valores_referencia_idReferencia_mao_de_obra, Orcamento_idPagamento),
    FOREIGN KEY (Valores_referencia_idReferencia_mao_de_obra) REFERENCES ValoresReferencia(idReferenciaDeMaoDeObra),
    FOREIGN KEY (Orcamento_idPagamento) REFERENCES Orcamento(idPagamento)
);

select * from Orcamento_has_Pecas;
show tables;
