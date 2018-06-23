SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for bc3fa8be0db46a3610db3ca0ec794c0b
-- ----------------------------
DROP TABLE IF EXISTS `bc3fa8be0db46a3610db3ca0ec794c0b`;
CREATE TABLE `bc3fa8be0db46a3610db3ca0ec794c0b` (
  `welcometoourctf` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of bc3fa8be0db46a3610db3ca0ec794c0b
-- ----------------------------
INSERT INTO `bc3fa8be0db46a3610db3ca0ec794c0b` VALUES ('sctf{C46E250926A2DFFD831975396222B08E}');

-- ----------------------------
-- Table structure for hlj_members
-- ----------------------------
DROP TABLE IF EXISTS `hlj_members`;
CREATE TABLE `hlj_members` (
  `user_id` int(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `submit` varchar(255) DEFAULT NULL,
  `defunct` varchar(255) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `accesstime` datetime DEFAULT NULL,
  `language` varchar(255) DEFAULT NULL,
  `reg_time` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of hlj_members
-- ----------------------------
INSERT INTO `hlj_members` VALUES ('1', '995857582@qq.com', '2', 'N', '127.0.0.1', '2018-05-11 16:03:14', 'CN', '2018-04-12 16:03:21', 'homamamama', '6yhn7ujm');
SET FOREIGN_KEY_CHECKS=1;