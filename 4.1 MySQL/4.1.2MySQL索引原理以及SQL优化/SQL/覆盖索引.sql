DROP TABLE IF EXISTS `covering_index_t`;
CREATE TABLE `covering_index_t` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(255) DEFAULT NULL,
	`cid` INT(11) DEFAULT NULL,
	`age` SMALLINT DEFAULT 0,
	`score` SMALLINT DEFAULT 0,
	PRIMARY KEY (`id`),
	KEY `name_cid_idx` (`name`, `cid`)
)ENGINE = INNODB AUTO_INCREMENT=0 DEFAULT CHARSET = utf8;


INSERT INTO `covering_index_t` (`name`, `cid`, `age`, `score`)
VALUES
	('mark', 10001, 12, 99),
	('darren', 10002, 13, 98),
	('vico', 10003, 14, 97),
	('king', 10004, 15, 100);

SHOW INDEX FROM `covering_index_t`;

EXPLAIN SELECT * FROM `covering_index_t` WHERE `name` = 'mark';

SELECT `name`, `cid`, `id` FROM `covering_index_t` WHERE `name` = 'mark';

EXPLAIN SELECT * FROM `covering_index_t` WHERE `cid` = 1 AND `name` = 'mark';

EXPLAIN SELECT `id`, `name` FROM `covering_index_t` WHERE `cid` = 1;
