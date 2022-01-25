DROP TABLE IF EXISTS `account_t`;
CREATE TABLE `account_t` (
	`id` INT(11) NOT NULL,
	`name` VARCHAR(255) DEFAULT NULL,
	`money` INT(11) DEFAULT 0,
	PRIMARY KEY (`id`),
	KEY `idx_name` (`name`)
)ENGINE = INNODB AUTO_INCREMENT=0 DEFAULT CHARSET = utf8;


INSERT INTO `account_t` VALUES (1, 'C', 1000),(2, 'B', 1000),(3, 'A', 1000);

-- 相反加锁顺序死锁1
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN
-- 死锁事务1
UPDATE FROM `account_t` SET `money` = `money` - 100 WHERE `id` = 1;
-- 死锁事务2
-- UPDATE FROM `account_t` SET `money` = `money` - 100 WHERE `id` = 2;
-- 死锁事务1
UPDATE FROM `account_t` SET `money` = `money` + 100 WHERE `id` = 2;
-- 死锁事务2
-- UPDATE FROM `account_t` SET `money` = `money` - 100 WHERE `id` = 1;

-- 相反加锁顺序死锁2
BEGIN
-- 死锁事务1
UPDATE FROM `account_t` SET `money` = `money` + 100 WHERE `name` >= 'A';
-- 死锁事务2
-- DELETE FROM `account_t` WHERE `id` >= 1;

-- 锁冲突死锁
BEGIN
-- 死锁事务1
UPDATE FROM `account_t` SET `money` = `money` + 100 WHERE `name` = 'C';
-- 死锁事务2
-- UPDATE FROM `account_t` SET `money` = `money` + 100 WHERE `name` = 'A';
-- 死锁事务1
INSERT INTO `account_t` (`id`,`name`,`money`) VALUES (4, 'BB', 1000);
-- 死锁事务2
-- INSERT INTO `account_t` (`id`,`name`,`money`) VALUES (5, 'CC', 1000);

