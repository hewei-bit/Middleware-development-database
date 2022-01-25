DROP TABLE IF EXISTS `left_match_t`;
CREATE TABLE `left_match_t` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(255) DEFAULT NULL,
	`cid` INT(11) DEFAULT NULL,
	`age` SMALLINT DEFAULT 0,
	PRIMARY KEY (`id`),
	KEY `name_cid_idx` (`name`, `cid`)
)ENGINE = INNODB AUTO_INCREMENT=0 DEFAULT CHARSET = utf8;


INSERT INTO `left_match_t` (`name`, `cid`, `age`)
VALUES
	('mark', 10001, 12),
	('darren', 10002, 13),
	('vico', 10003, 14),
	('king', 10004, 15)

SHOW INDEX FROM `left_match_t`;

# 作用优化器
EXPLAIN SELECT * FROM `left_match_t` WHERE `name` = 'mark';

# 优化器
EXPLAIN SELECT * FROM `left_match_t` WHERE `cid` = 1 AND `name` = 'mark';

EXPLAIN SELECT * FROM `left_match_t` WHERE `cid` = 1;
