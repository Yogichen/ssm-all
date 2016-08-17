/*
Navicat MySQL Data Transfer

Source Server         : mysql-local
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : shang-help

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2016-08-16 11:41:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `introduce` varchar(500) DEFAULT NULL,
  `created_by` varchar(255) NOT NULL,
  `plain_text` longtext,
  `full_html` longtext,
  `create_date` datetime DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `article_category_id` (`category_id`),
  CONSTRAINT `article_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `icon_path` varchar(500) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `temp` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` varchar(500) DEFAULT NULL,
  `pid` bigint(20) DEFAULT NULL,
  `comment_date` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `published_article_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `comment_published_article_id` (`published_article_id`),
  CONSTRAINT `comment_published_article_id` FOREIGN KEY (`published_article_id`) REFERENCES `published_article` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for published_article
-- ----------------------------
DROP TABLE IF EXISTS `published_article`;
CREATE TABLE `published_article` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `introduce` varchar(500) DEFAULT NULL,
  `created_by` varchar(255) NOT NULL,
  `plain_text` longtext,
  `full_html` longtext,
  `create_date` datetime DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `temp_article_id` bigint(20) DEFAULT NULL,
  `like_num` int(11) DEFAULT '0',
  `temp` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `published_article_category_id` (`category_id`),
  KEY `published_article_temp_article_id` (`temp_article_id`),
  CONSTRAINT `published_article_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `published_article_temp_article_id` FOREIGN KEY (`temp_article_id`) REFERENCES `article` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `link` varchar(200) NOT NULL,
  `order_number` int(11) NOT NULL,
  `visible` bit(1) NOT NULL,
  `icon_class` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint(20) NOT NULL,
  `menu_id` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id`,`menu_id`),
  KEY `role_menu_menu_id` (`menu_id`),
  CONSTRAINT `role_menu_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `sys_menu` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `role_menu_role_id` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `real_name` varchar(255) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `role_id` bigint(20) NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user_name`),
  KEY `user_role_id` (`role_id`),
  CONSTRAINT `user_role_id` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '', '管理员');
INSERT INTO `sys_role` VALUES ('2', null, '小编');

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '分类管理', '/category/view', '1', '', 'fa meun-type');
INSERT INTO `sys_menu` VALUES ('2', '文章管理', '/article/view', '2', '', 'fa meun-article');
INSERT INTO `sys_menu` VALUES ('3', '帐号管理', '/account/view', '3', '', 'fa meun-number');
INSERT INTO `sys_menu` VALUES ('4', '我的帐号', '/account/myAccount/view', '4', '', 'fa meun-myself');

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('1', '1');
INSERT INTO `sys_role_menu` VALUES ('1', '2');
INSERT INTO `sys_role_menu` VALUES ('1', '3');
INSERT INTO `sys_role_menu` VALUES ('1', '4');
INSERT INTO `sys_role_menu` VALUES ('2', '2');
INSERT INTO `sys_role_menu` VALUES ('2', '4');

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('admin', 'e10adc3949ba59abbe56e057f20f883e', 'admin', '888888', '1', '1');

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', 'FAQ', '常见问题', 'admin', null, now(), null, '1', '1', null);
INSERT INTO `category` VALUES ('2', '工单管理', '功能模块', 'admin', null, now(), null, '1', '2', null);
INSERT INTO `category` VALUES ('3', '其他', '其他', 'admin', null, now(), null, '1', '3', null);

