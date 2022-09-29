
/* 1. Crie um stored procedure que receba id de cliente, data inicial e data final e que mostre a lista de compras realizadas pelo referido cliente entre as datas informadas (incluindo essas datas), mostrando nome do cliente, id da compra, total, nome e quantidade de cada produto comprado. No script, inclua o código de criação e uma chamada ao procedure. */

DELIMITER //
CREATE PROCEDURE info_compra (cliente_id int, data_inicial date, data_final date)
BEGIN 

	SELECT c.nome, v.id, v.data, v.data_envio, v.valor_total, i.nome_produto, i.quantidade
	FROM cliente c
	INNER JOIN venda v on c.id = v.cliente_id
	INNER JOIN item_venda i on v.id = i.venda_id
	WHERE DATA BETWEEN data_inicial AND data_final AND cliente_id = c.id;

END//
DELIMITER ;

CALL info_compra('1', '2019-01-01', '2020-11-01')


/* Crie uma stored function que receba id de funcionário, data inicial e data final e retorne a comissão total desse funcionário no período indicado. No script, inclua o código de criação e uma chamada à function. */

DELIMITER //
CREATE FUNCTION info_funcionario(funcionario_id int, data_inicial date, data_final date) 
RETURNS DECIMAL(15,2) DETERMINISTIC 
BEGIN

	DECLARE info_nome varchar(200);
	DECLARE info_totalvendas decimal(9,2);
	DECLARE info_comissao int;

	SELECT f.nome, sum(v.valor_total), c.comissao INTO info_nome, info_totalvendas, info_comissao 
	FROM funcionario f 
	INNER JOIN cargo c on c.id = f.cargo_id 
	INNER JOIN venda v on f.id = v.funcionario_id
	WHERE DATA BETWEEN data_inicial and data_final AND f.id = funcionario_id;

RETURN info_totalvendas * (info_comissao / 100);
END//
DELIMITER ;

SELECT info_funcionario('1', '2019-01-01', '2021-01-01')


/* Crie uma stored function que receba id de cliente e retorne se o cliente é “PREMIUM” ou “REGULAR”. Um cliente é “PREMIUM” se já realizou mais de R$ 10 mil em compras nos últimos dois anos. Um cliente é “REGULAR” se ao contrário. No script, inclua o código de criação e uma chamada à function. */

DELIMITER //
CREATE FUNCTION status_cliente (cliente_id int)
RETURNS VARCHAR(10) DETERMINISTIC
BEGIN

	DECLARE consulta_total decimal(10,2);
	DECLARE consulta_status varchar(15);

	SELECT sum(v.valor_total) into consulta_total from venda v 
	INNER JOIN cliente c on v.cliente_id = c.id
	WHERE c.id = cliente_id and v.data between CURDATE() - interval 730 day and CURDATE();

	IF consulta_total > 10000.00 THEN
		SET consulta_status = 'PREMIUM';
	ELSE 
		SET consulta_status = 'RELUGAR';
	END IF;

RETURN consulta_status;
END//

DELIMITER ;

SELECT status_cliente(10);


/* 4. Crie um trigger que atue sobre a tabela “usuário” de modo que, ao incluir um novo usuário, aplique automaticamente MD5() à coluna “senha”. */

DELIMITER //
CREATE TRIGGER cripto_senha BEFORE INSERT
ON usuario
FOR EACH ROW
BEGIN
	
    SET new.senha = md5(new.senha);
    
END//
DELIMITER ;

INSERT INTO usuario (id, login, senha, ultimo_login)
	VALUES ('12', 'Guilber', 'mlnkbj', '2022-09-29 12:00:00');

/* select * from usuario;