SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `wst_shop_member_groups`;
CREATE TABLE `wst_shop_member_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupName` varchar(50) DEFAULT NULL COMMENT '商家会员分组',
  `shopId` int(11) DEFAULT NULL COMMENT '商家ID',
  `groupOrder` int(11) DEFAULT '0' COMMENT '排序号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;