use oficina; 
-- Inserindo dados na tabela Cliente
INSERT INTO Cliente (idCliente, Nome, CPF) VALUES
(1, 'João Silva', '12345678901'),
(2, 'Maria Souza', '98765432109'),
(3, 'Ricardo Almeida', '34567890123'),
(4, 'Fernanda Oliveira', '65432109876'),
(5, 'Lucas Pereira', '78901234567'),
(6, 'Amanda Castro', '23456789012');



-- Inserindo dados na tabela EquipeMecanicos
INSERT INTO EquipeMecanicos (idMecanicos, Nome, Endereco, Codigo, Especialidade,idVeiculosMEC) VALUES
(1, 'Pedro Alves', 'Rua A, 10', 'MEC001', 'Motor', 1),
(2, 'Ana Paula', 'Rua B, 20', 'MEC002', 'Freio', 2),
(3, 'Carla Souza', 'Rua C, 30', 'MEC003', 'Elétrica', 3),
(4, 'Bruno Santos', 'Rua D, 40', 'MEC004', 'Suspensão', 4),
(5, 'Juliana Oliveira', 'Rua E, 50', 'MEC005', 'Injeção Eletrônica', 5),
(6, 'Roberto Silva', 'Rua F, 60', 'MEC006', 'Ar Condicionado', 6);

-- Inserindo dados na tabela Veiculos
INSERT INTO Veiculos (idVeiculos, Modelo, Marca,idClienteVec) VALUES
(1, 'Corsa', 'Chevrolet', 1),
(2, 'Palio', 'Fiat', 2),
(3, 'Uno', 'Fiat', 3),
(4, 'Gol', 'Volkswagen', 4),
(5, 'Civic', 'Honda', 5),
(6, 'Fiesta', 'Ford', 6);

select * from Veiculos;
-- Orçamentos (9 registros)
INSERT INTO Orcamento (idPagamento) VALUES
(NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL);

-- Inserindo dados na tabela Servicos
INSERT INTO Servicos (idServicos, Conserto, Revisao, Orcamento_pagamento) VALUES
(1, 'Troca de óleo', 'Revisão geral', 1),
(2, 'Alinhamento e balanceamento', NULL, 2),
(3, NULL, 'Revisão de freios', 3),
(4, 'Reparo na injeção eletrônica', NULL, 4),
(5, NULL, 'Revisão de ar condicionado', 5),
(6, 'Troca de embreagem', NULL, 6),
(7, 'Troca de correia dentada', NULL, 7),
(8, NULL, 'Revisão preventiva 50.000 km', 8),
(9, 'Reparo no sistema de direção', NULL, 9);



INSERT INTO Pecas (idPecas,NomeP, Valores) VALUES
(1, 'Filtro de óleo', 500.00),
(2, 'Pastilhas de freio', 120.00),
(3, 'Amortecedores' ,250.00),
(4, 'Sensor de oxigênio', 320.00),
(5, 'Gás refrigerante',800.00),
(6, 'Kit embreagem',950.00);



INSERT INTO OS (Número, Data_de_emissão, Status, Data_conclusão, Pecas, Referencia_de_mão_de_obra, IdMecanicosOS) VALUES
('OS001', '2025-04-01 10:00:00', 'Em andamento', NULL, 'Filtro de óleo', 'Troca de óleo Honda Civic', 1),
('OS002', '2025-04-02 11:00:00', 'Concluído', '2025-04-03 15:00:00', NULL, 'Alinhamento Toyota Corolla', 2),
('OS003', '2025-04-05 09:30:00', 'Em andamento', NULL, NULL, NULL, 3),
('OS004', '2025-04-06 14:00:00', 'Aguardando peças', NULL, 'Sensor de oxigênio', 'Diagnóstico eletrônico HB20', 4),
('OS005', '2025-04-07 09:00:00', 'Concluído', '2025-04-08 17:00:00', 'Gás refrigerante', 'Recarga de ar condicionado Onix', 5),
('OS006', '2025-04-08 10:30:00', 'Em andamento', NULL, 'Kit embreagem completo', 'Troca de embreagem T-Cross', 6);

select Número, Data_de_emissão from OS;
INSERT INTO ValoresReferencia (idReferenciaDeMaoDeObra, ValoresServico) VALUES
(1, 150.50),
(2, 200.75),
(3, 300.00),
(4, 450.00),
(5, 180.00),
(6, 600.00);


SELECT 
    S.idServicos AS ID_Servico,
    COALESCE(S.Conserto, S.Revisao) AS Tipo_Servico,
    COALESCE(VR.ValoresServico, 0) AS Custo_Mao_de_Obra,
    COALESCE(SUM(P.Valores), 0) AS Custo_Pecas,
    COALESCE(VR.ValoresServico, 0) + COALESCE(SUM(P.Valores), 0) AS Custo_Total
FROM 
    Servicos S
LEFT JOIN 
    Valores_referencia_has_Orçamento VRO ON S.Orcamento_pagamento = VRO.Orcamento_idPagamento
LEFT JOIN 
    ValoresReferencia VR ON VRO.Valores_referencia_idReferencia_mao_de_obra = VR.idReferenciaDeMaoDeObra
LEFT JOIN 
    Orcamento_has_Pecas OHP ON S.Orcamento_pagamento = OHP.idPagamentoORC
LEFT JOIN 
    Pecas P ON OHP.idPecasORC = P.idPecas
GROUP BY 
    S.idServicos, VR.ValoresServico
ORDER BY 
    Custo_Total DESC;

-- Relacionamentos Orçamento-Peças (9 registros)
INSERT INTO Orcamento_has_Pecas (idPagamentoORC, idPecasORC) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6),
(7, 1), (8, 2), (9, 3);  -- Associações extras para serviços 7-9
delete from Orcamento_has_Pecas;

-- Relacionamentos Valores-Orçamento (9 registros)
INSERT INTO Valores_referencia_has_Orçamento(Valores_referencia_idReferencia_mao_de_obra,Orcamento_idPagamento) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6),
(1, 7), (2, 8), (3, 9);  -- Associações extras para serviços 7-9

-- Relacionamentos OS-Peças (6 registros)
INSERT INTO OSHasPecas (OS_idOS, Pecas_idPecas) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6);

-- Autorizações Cliente-Serviço (3 registros extras)
INSERT INTO ClienteAutorizaServico (idClienteAutoriza, idServicosAutoriza) VALUES
(1, 7), (2, 8), (3, 9);

-- Mecânicos por Serviço (3 registros extras)
INSERT INTO MecanicosIdentificaServico (idMecanicos_ident, idServicos_ident) VALUES
(1, 7), (2, 8), (3, 9),(1, 3);



-- SELECT
select * from Pecas where Valores > 300.00;

-- Seleciona os concertos que não possuem revisão(WHERE)
select Conserto, idServicos COD_Serviços from Servicos where Revisao is NULL;

-- WHERE E ORDER BY
select * from pecas order by Valores asc;
select * from Pecas where Valores > 300.00;

-- Clientes que possuem o carro da marca FIAT - (WHERE com JOIN)
select c.nome, v.marca from Cliente c join Veiculos v on idCliente = IdClienteVec where Marca = 'Fiat';

-- clientes em ordem contrária alfabética (ORDER BY)
select * from Cliente order by Nome desc;

-- (ORDER BY)
SELECT Nome, Especialidade FROM EquipeMecanicos 
ORDER BY Especialidade ASC,  -- Ordem alfabética crescente por especialidade
Nome ASC;           -- Ordem alfabética crescente por nome dentro de cada especialidade


-- Criar coluna com ATRIBUTOS DERIVADOS
select concat(Nome,' - ',CPF) as Dados_cliente from Cliente;

-- HAVING
select NomeP, AVG(Valores) as valor_medio from pecas p group by NomeP having AVG(Valores) > 100.00;

-- HAVING
SELECT idServicos_ident AS ID_Serviço, COUNT(idMecanicos_ident) AS Total_Mecânicos
FROM MecanicosIdentificaServico
GROUP BY idServicos_ident
HAVING COUNT(idMecanicos_ident) = 1;


-- serviços que os cliente autorizou e qual mecanico cuidou - (JOIN)
select c.nome, s.Conserto, e.Nome from Cliente c join ClienteAutorizaServico CAS on c.idCliente = CAS.idClienteAutoriza
join Servicos s on s.idServicos = CAS.idServicosAutoriza join MecanicosIdentificaServico MIS on MIS.idServicos_ident = s.idServicos 
join EquipeMecanicos e on e.idMecanicos = MIS.idMecanicos_ident;

-- peças utilizadas em cada ordem de serviço (JOIN)
select p.Nomep, os.Número from OS os join OShasPecas OSP on os.idOS = OSP.OS_idOS join Pecas p on p.idPecas = OSP.Pecas_idPecas;

SELECT COUNT(*) AS total_tabelas 
FROM information_schema.tables 
WHERE table_schema = 'oficina' AND table_type = 'BASE TABLE';



