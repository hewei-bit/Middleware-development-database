DROP TABLE IF EXISTS `account_t`;
CREATE TABLE `account_t` (
	`id` INT(11) NOT NULL,
	`name` VARCHAR(255) DEFAULT NULL,
	`money` INT(11) DEFAULT 0,
	PRIMARY KEY (`id`),
	KEY `idx_name` (`name`)
)ENGINE = INNODB AUTO_INCREMENT=0 DEFAULT CHARSET = utf8;

SELECT * from account_t;


INSERT INTO `account_t` VALUES (1, 'C', 1000),(2, 'B', 1000),(3, 'A', 1000);

-- 脏读读取了另一个事务未提交的修改 （其他事务的修改影响了本事务的读取）
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN
-- 脏读事务1
UPDATE account_t SET money = money - 100 WHERE name = 'A';
-- 脏读事务2
-- SELECT money FROM account_t WHERE name = 'A';
-- SELECT money FROM account_t WHERE name = 'B';
-- 脏读事务1
UPDATE account_t SET money = money + 100 WHERE name = 'B';
-- 脏读事务1
COMMIT;
-- 脏读事务2
-- COMMIT

-- 不可重复读读取了另一个事务提交之后的修改（其他事务的修改影响了本事务的读取）
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN
-- 不可重复读事务2
-- SELECT money FROM account_t WHERE name = 'A';
-- 不可重复读事务1
UPDATE account_t SET money = money - 100 WHERE name = 'A';
-- 不可重复读事务1
COMMIT;
-- 不可重复读事务2
-- SELECT money FROM account_t WHERE name = 'A';
-- COMMIT

-- 幻读两次读取得到的结果集不一样
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN
-- 幻读事务2
-- SELECT * FROM account_t WHERE id >= 2;
-- 幻读事务1
INSERT INTO account_t(id,name,money) VALUES (4,'D',1000);
-- 幻读事务1
COMMIT
-- 幻读事务2
-- SELECT * FROM account_t WHERE id >= 2;
-- COMMIT;


-- 丢失更新（提交覆盖）
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN
-- 丢失更新事务1
SELECT money FROM account_t WHERE name = 'A';
-- 丢失更新事务2
-- SELECT money FROM account_t WHERE name = 'A';
-- UPDATE account_t SET money = 1100 WHERE name = 'A';
-- COMMIT;
-- 丢失更新事务1
UPDATE account_t SET money = 900 WHERE name = 'A';
COMMIT;






