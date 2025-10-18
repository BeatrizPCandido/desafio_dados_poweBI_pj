# desafio_dados_poweBI_pj

📊 Projeto de Integração SQL Server + Power BI

🧩 Descrição do Projeto

Este projeto tem como objetivo a criação e análise de uma base de dados relacional simulando uma estrutura corporativa, com foco em funcionários, departamentos, projetos e dependentes. A base foi construída no SQL Server e integrada ao Power BI para visualização e análise.

🛠️ Componentes Criados

🗃️ Banco de Dados

- Nome: desafio_dados (ou company_constraints)
  
🧱 Tabelas

- employee: informações dos colaboradores
- departament: dados dos departamentos
- dept_locations: localizações dos departamentos
- project: projetos em andamento
- works_on: vínculo entre funcionários e projetos
- dependent: dependentes dos colaboradores
  
🔗 Relacionamentos

- Chaves primárias e estrangeiras entre as tabelas
- Super_ssn como autorreferência na tabela employee
- Dno como vínculo entre employee e departament
  
📥 Dados Inseridos

- População das tabelas com dados simulados
- Inserções realizadas via comandos INSERT INTO

🔄 Diretrizes de Transformação de Dados

- Verificação de cabeçalhos e tipos de dados
- Todos os campos foram revisados para garantir consistência com os tipos esperados.
- Conversão de valores monetários para FLOAT
- Salários foram tratados como DECIMAL(10,2) no SQL Server e convertidos para FLOAT no Power BI.
- Análise e tratamento de valores nulos
- Verificação de campos nulos em Super_ssn e Mgr_ssn.
- Identificação de gerentes
- Funcionários com Super_ssn = NULL foram considerados gerentes.
- Verificação de departamentos sem gerente
- Todos os departamentos foram validados para conter Mgr_ssn.
- Preenchimento de lacunas gerenciais
- Caso algum departamento estivesse sem gerente, os dados foram completados manualmente.
- Validação de horas em projetos
- Verificação de horas trabalhadas por projeto na tabela works_on.
- Separação de colunas complexas
- Endereços e nomes foram tratados para facilitar visualizações.
- Mescla de employee com departament
- Criada VIEW SQL para unir colaboradores com seus departamentos:
  
CREATE VIEW vw_funcionarios_departamento AS
SELECT 
    e.Ssn,
    e.Fname + ' ' + e.Lname AS NomeCompleto,
    e.Salary,
    d.Dname AS Departamento
FROM employee e
JOIN departament d ON e.Dno = d.Dnumber;

- Eliminação de colunas desnecessárias
- Colunas como Minit e Super_ssn foram ocultadas no Power BI para simplificação.
- Junção com nomes dos gerentes
- Consulta SQL para obter nome do gerente de cada colaborador:
  
SELECT 
    e.Fname + ' ' + e.Lname AS Colaborador,
    m.Fname + ' ' + m.Lname AS Gerente
FROM employee e
LEFT JOIN employee m ON e.Super_ssn = m.Ssn;

- Mescla de nome e sobrenome
- Criada coluna NomeCompleto no SQL e no Power BI.
- Mescla de departamento e localização
- Criada coluna Departamento_Local no Power BI:




📈 Integração com Power BI

- Conexão realizada via Banco de Dados SQL Server
- Modo de conexão: Importar
- Tabelas e views selecionadas: employee, departament, vw_funcionarios_departamento, works_on, project
- Transformações adicionais realizadas no Power Query
