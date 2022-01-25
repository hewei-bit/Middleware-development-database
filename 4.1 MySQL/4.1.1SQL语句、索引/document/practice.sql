/*
 Navicat MySQL Data Transfer
 
 Source Server         : localhost
 Source Server Version : 50734
 Source Host           : localhost:3306
 Source Database       : practice
 
 Target Server Type    : MYSQL
 Target Server Version : 50734
 File Encoding         : 65001
 
 */
SET FOREIGN_KEY_CHECKS = 0;
-- ----------------------------
-- Table structure for class
-- ----------------------------
DROP TABLE IF EXISTS `class`;
CREATE TABLE `class` (
    `cid` int(11) NOT NULL AUTO_INCREMENT,
    `caption` varchar(32) NOT NULL,
    PRIMARY KEY (`cid`)
) ENGINE = InnoDB AUTO_INCREMENT = 5 DEFAULT CHARSET = utf8;
-- ----------------------------
-- Records of class
-- ----------------------------
INSERT INTO `class`
VALUES ('1', '1908班');
INSERT INTO `class`
VALUES ('2', '2004班');
INSERT INTO `class`
VALUES ('3', '2101班');
INSERT INTO `class`
VALUES ('4', '2109班');
-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
    `cid` int(11) NOT NULL AUTO_INCREMENT,
    `cname` varchar(32) NOT NULL,
    `teacher_id` int(11) NOT NULL,
    PRIMARY KEY (`cid`),
    KEY `fk_course_teacher` (`teacher_id`),
    CONSTRAINT `fk_course_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`tid`)
) ENGINE = InnoDB AUTO_INCREMENT = 6 DEFAULT CHARSET = utf8;
-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course`
VALUES ('1', 'c++高级架构', '1');
INSERT INTO `course`
VALUES ('2', '音视频', '2');
INSERT INTO `course`
VALUES ('3', 'linux内核源码剖析', '4');
INSERT INTO `course`
VALUES ('4', 'go云原生', '2');
INSERT INTO `course`
VALUES ('5', 'dpdk网络协议栈', '1');
-- ----------------------------
-- Table structure for score
-- ----------------------------
DROP TABLE IF EXISTS `score`;
CREATE TABLE `score` (
    `sid` int(11) NOT NULL AUTO_INCREMENT,
    `student_id` int(11) NOT NULL,
    `course_id` int(11) NOT NULL,
    `num` int(11) NOT NULL,
    PRIMARY KEY (`sid`),
    KEY `fk_score_student` (`student_id`),
    KEY `fk_score_course` (`course_id`),
    CONSTRAINT `fk_score_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`cid`),
    CONSTRAINT `fk_score_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`sid`)
) ENGINE = InnoDB AUTO_INCREMENT = 58 DEFAULT CHARSET = utf8;
-- ----------------------------
-- Records of score
-- ----------------------------
INSERT INTO `score`
VALUES ('1', '1', '1', '10');
INSERT INTO `score`
VALUES ('2', '1', '2', '59');
INSERT INTO `score`
VALUES ('3', '4', '5', '100');
INSERT INTO `score`
VALUES ('4', '5', '4', '67');
INSERT INTO `score`
VALUES ('5', '2', '2', '66');
INSERT INTO `score`
VALUES ('6', '2', '1', '58');
INSERT INTO `score`
VALUES ('8', '2', '3', '68');
INSERT INTO `score`
VALUES ('9', '2', '4', '99');
INSERT INTO `score`
VALUES ('10', '3', '1', '77');
INSERT INTO `score`
VALUES ('11', '3', '2', '66');
INSERT INTO `score`
VALUES ('12', '3', '3', '87');
INSERT INTO `score`
VALUES ('13', '3', '4', '99');
INSERT INTO `score`
VALUES ('14', '4', '1', '79');
INSERT INTO `score`
VALUES ('15', '4', '2', '11');
INSERT INTO `score`
VALUES ('16', '4', '3', '67');
INSERT INTO `score`
VALUES ('17', '4', '4', '100');
INSERT INTO `score`
VALUES ('18', '5', '1', '79');
INSERT INTO `score`
VALUES ('19', '5', '2', '11');
INSERT INTO `score`
VALUES ('20', '5', '3', '67');
INSERT INTO `score`
VALUES ('21', '5', '5', '100');
INSERT INTO `score`
VALUES ('22', '6', '1', '9');
INSERT INTO `score`
VALUES ('23', '6', '2', '100');
INSERT INTO `score`
VALUES ('24', '6', '3', '67');
INSERT INTO `score`
VALUES ('25', '6', '4', '100');
INSERT INTO `score`
VALUES ('26', '7', '1', '9');
INSERT INTO `score`
VALUES ('27', '7', '2', '100');
INSERT INTO `score`
VALUES ('28', '7', '3', '67');
INSERT INTO `score`
VALUES ('29', '7', '4', '88');
INSERT INTO `score`
VALUES ('30', '8', '1', '49');
INSERT INTO `score`
VALUES ('31', '8', '2', '100');
INSERT INTO `score`
VALUES ('32', '8', '3', '67');
INSERT INTO `score`
VALUES ('33', '8', '4', '88');
INSERT INTO `score`
VALUES ('34', '9', '1', '91');
INSERT INTO `score`
VALUES ('35', '9', '2', '88');
INSERT INTO `score`
VALUES ('36', '9', '5', '67');
INSERT INTO `score`
VALUES ('37', '9', '4', '22');
INSERT INTO `score`
VALUES ('38', '10', '1', '90');
INSERT INTO `score`
VALUES ('39', '10', '2', '77');
INSERT INTO `score`
VALUES ('40', '10', '3', '43');
INSERT INTO `score`
VALUES ('41', '10', '4', '87');
INSERT INTO `score`
VALUES ('42', '11', '1', '90');
INSERT INTO `score`
VALUES ('43', '11', '2', '77');
INSERT INTO `score`
VALUES ('44', '11', '5', '43');
INSERT INTO `score`
VALUES ('45', '11', '4', '87');
INSERT INTO `score`
VALUES ('46', '12', '1', '90');
INSERT INTO `score`
VALUES ('47', '12', '2', '77');
INSERT INTO `score`
VALUES ('48', '12', '3', '43');
INSERT INTO `score`
VALUES ('49', '12', '5', '87');
INSERT INTO `score`
VALUES ('50', '13', '3', '87');
INSERT INTO `score`
VALUES ('51', '14', '2', '33');
INSERT INTO `score`
VALUES ('52', '15', '3', '22');
INSERT INTO `score`
VALUES ('53', '15', '5', '11');
INSERT INTO `score`
VALUES ('54', '13', '1', '99');
INSERT INTO `score`
VALUES ('55', '13', '2', '99');
INSERT INTO `score`
VALUES ('56', '13', '4', '67');
INSERT INTO `score`
VALUES ('57', '13', '5', '87');
-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
    `sid` int(11) NOT NULL AUTO_INCREMENT,
    `gender` char(1) NOT NULL,
    `class_id` int(11) NOT NULL,
    `sname` varchar(32) NOT NULL,
    PRIMARY KEY (`sid`),
    KEY `fk_class` (`class_id`),
    CONSTRAINT `fk_class` FOREIGN KEY (`class_id`) REFERENCES `class` (`cid`)
) ENGINE = InnoDB AUTO_INCREMENT = 17 DEFAULT CHARSET = utf8;
-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student`
VALUES ('1', '男', '1', '罗谊');
INSERT INTO `student`
VALUES ('2', '女', '1', '戴巧');
INSERT INTO `student`
VALUES ('3', '男', '1', '叶黎');
INSERT INTO `student`
VALUES ('4', '男', '3', '邵柴');
INSERT INTO `student`
VALUES ('5', '女', '1', '韩琪');
INSERT INTO `student`
VALUES ('6', '男', '3', '尹伸');
INSERT INTO `student`
VALUES ('7', '女', '2', '孙燕');
INSERT INTO `student`
VALUES ('8', '男', '2', '廖宽');
INSERT INTO `student`
VALUES ('9', '男', '2', '孙行');
INSERT INTO `student`
VALUES ('10', '女', '2', '宋贤');
INSERT INTO `student`
VALUES ('11', '男', '2', '谭国兴');
INSERT INTO `student`
VALUES ('12', '女', '3', '于怡瑶');
INSERT INTO `student`
VALUES ('13', '男', '4', '文乐逸');
INSERT INTO `student`
VALUES ('14', '男', '4', '邹乐和');
INSERT INTO `student`
VALUES ('15', '女', '5', '邓洋洋');
INSERT INTO `student`
VALUES ('16', '男', '5', '秦永福');
-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
    `tid` int(11) NOT NULL AUTO_INCREMENT,
    `tname` varchar(32) NOT NULL,
    PRIMARY KEY (`tid`)
) ENGINE = InnoDB AUTO_INCREMENT = 6 DEFAULT CHARSET = utf8;
-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher`
VALUES ('1', '王天一老师');
INSERT INTO `teacher`
VALUES ('2', '谢小二老师');
INSERT INTO `teacher`
VALUES ('3', '廖阿三老师');
INSERT INTO `teacher`
VALUES ('4', '吴启四老师');
INSERT INTO `teacher`
VALUES ('5', '谢飞五老师');