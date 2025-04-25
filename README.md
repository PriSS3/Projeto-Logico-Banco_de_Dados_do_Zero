# Projeto Lógico de Banco de Dados do Zero
Projeto feito em BootCamp da DIO.
Objetivo:
Criar o esquema conceitual para o contexto de oficina com base na narrativa fornecida.

Sistema para a gestão de ordens de serviço (OS) em oficinas mecânicas, que inclui o registro de clientes, veículos, equipes, mecânicos e itens (peças e mão de obra).

Criar um esquema lógico a partir do conceitual

Narrativa do esquema conceitual:
- Sistema de controle e gerenciamento de execução de ordens de serviço em uma oficina mecânica
- Clientes levam veículos à oficina mecânica para serem consertados ou para passarem por revisões  periódicas
- Cada veículo é designado a uma equipe de mecânicos que identifica os serviços a serem executados e preenche uma OS com data de entrega.
- A partir da OS, calcula-se o valor de cada serviço, consultando-se uma tabela de referência de mão-de-obra
- O valor de cada peça também irá compor a OSO cliente autoriza a execução dos serviços
- A mesma equipe avalia e executa os serviços
- Os mecânicos possuem código, nome, endereço e especialidade
- Cada OS possui: n°, data de emissão, um valor, status e uma data para conclusão dos trabalhos.

Apoís a criação do esquema lógico, realizar a criação do Script SQL para criação do esquema do banco de dados. Posteriormente, realizando a persistência de dados para realização de testes.

- Recuperações simples com SELECT Statement;
- Filtros com WHERE Statement;
- Crie expressões para gerar atributos derivados;
- Defina ordenações dos dados com ORDER BY;
- Condições de filtros aos grupos – HAVING Statement;
- Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados;
 
Ferramentas utilizadas:
- MySQL Workbench
