
/* 1. Crie um usuário específico para relatórios. Crie role para ele, com acesso apenas à consulta em tabelas (nem dados, nem estrutura podem ser alterados). */

CREATE USER 'relatorio'@'localhost' IDENTIFIED by 'relatorio123';
CREATE ROLE 'app_consulta';
GRANT SELECT ON uc4atividades.* TO 'app_consulta';
GRANT 'app_consulta' TO 'relatorio'@'localhost';
FLUSH privileges;


/* 2. Crie usuário e role para funcionário, o qual pode manipular as tabelas de venda, cliente e produto, mas não deve ter acesso (nem para consulta) a funcionário e cargo e não deve ser capaz de realizar alterações de estrutura em nenhuma tabela. */ 

CREATE USER 'funcionario'@'localhost' IDENTIFIED by 'funcionario123';
CREATE ROLE 'app_funcionario';
GRANT INSERT ON uc4atividades.venda TO 'app_funcionario';
GRANT INSERT ON uc4atividades.cliente TO 'app_funcionario';
GRANT INSERT ON uc4atividades.produto TO 'app_funcionario';
GRANT 'app_funcionario' TO 'funcionario'@'localhost';
FLUSH privileges;


/* 3. Escolha um método de criptografia ou hash para aplicar às senhas dos usuários. Atualize a tabela “usuário” aplicando a criptografia ou hash ao campo de senha em todos os registros. */

UPDATE usuario SET senha = md5('12345') WHERE id = 1;
UPDATE usuario SET senha = md5('67890') WHERE id = 2;
UPDATE usuario SET senha = md5('1q2w3e') WHERE id = 3;
UPDATE usuario SET senha = md5('sil123') WHERE id = 4;
UPDATE usuario SET senha = md5('ama123') WHERE id = 5;
UPDATE usuario SET senha = md5('mar123') WHERE id = 6;
UPDATE usuario SET senha = md5('dom123') WHERE id = 7;
UPDATE usuario SET senha = md5('mar123') WHERE id = 8;
UPDATE usuario SET senha = md5('joa123') WHERE id = 9;
UPDATE usuario SET senha = md5('apa123') WHERE id = 10;
UPDATE usuario SET senha = md5('fil123') WHERE id = 11;


