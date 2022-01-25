DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
	`id` BIGINT,
	`nick` VARCHAR (100),
	`height` INT8,
	`sex` VARCHAR (1),
	`age` INT8,
	PRIMARY KEY (`id`)
) ENGINE = INNODB DEFAULT CHARSET = utf8;
