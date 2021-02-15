SET FOREIGN_KEY_CHECKS=0;


DROP TABLE IF EXISTS `wst_shop_bases`;
CREATE TABLE `wst_shop_bases` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `flowId` int(11) DEFAULT '0' COMMENT '流程ID',
  `fieldName` varchar(50) DEFAULT '' COMMENT '表单字段',
  `dataType` varchar(10) DEFAULT '' COMMENT '数据类型',
  `fieldTitle` varchar(50) DEFAULT '' COMMENT '表单标题',
  `dataLength` int(11) DEFAULT '0' COMMENT '数据长度',
  `fieldSort` tinyint(4) unsigned DEFAULT '0' COMMENT '显示排序',
  `isRequire` tinyint(4) unsigned DEFAULT '0' COMMENT '是否必填，0否，1是',
  `fieldComment` varchar(255) DEFAULT '' COMMENT '表单注释',
  `fieldType` varchar(10) DEFAULT '' COMMENT '表单类型',
  `fieldAttr` varchar(255) DEFAULT '' COMMENT '表单属性',
  `isRelevance` tinyint(4) unsigned DEFAULT '0' COMMENT '是否关联字段，0否，1是',
  `fieldRelevance` varchar(50) DEFAULT '' COMMENT '关联字段',
  `dateRelevance` varchar(100) DEFAULT '' COMMENT '日期关联字段',
  `timeRelevance` varchar(100) DEFAULT '' COMMENT '时间关联字段',
  `isShow` tinyint(4) unsigned DEFAULT '1' COMMENT '是否显示，0隐藏，1显示',
  `isMap` tinyint(4) unsigned DEFAULT '0' COMMENT '是否显示地图，0隐藏，1显示',
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `dataFlag` tinyint(4) NOT NULL DEFAULT '1' COMMENT '有效状态 1:有效  -1:删除',
  `isDelete` tinyint(4) DEFAULT '1' COMMENT '是否可以删除，0否，1是',
  `isShopsTable` tinyint(4) DEFAULT '0' COMMENT '是否在wst_shops表，0不是，1是',
  `fileNum` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4;


INSERT INTO `wst_shop_bases` VALUES ('1', '2', 'shopCompany', 'varchar', '公司名称', '255', '0', '1', '', 'input', '255', '0', '', '', '', '1', '0', '2019-03-28 09:10:27', '1', '0', '1', null),
('2', '2', 'areaIdPath', 'varchar', '公司所在地', '255', '0', '1', '', 'other', 'area', '0', '', '', '', '1', '1', '2019-03-28 09:20:21', '1', '0', '1', null),
('3', '2', 'shopAddress', 'varchar', '公司详细地址', '255', '0', '1', '', 'input', '255', '0', '', '', '', '1', '0', '2019-03-28 09:24:39', '1', '0', '1', null),
('4', '2', 'shopTel', 'varchar', '公司电话', '40', '0', '1', '', 'input', '40', '0', '', '', '', '1', '0', '2019-03-28 09:25:40', '1', '0', '1', null),
('5', '3', 'shopName', 'varchar', '店铺名称', '100', '0', '1', '', 'input', '100', '0', '', '', '', '1', '0', '2019-03-28 18:06:13', '1', '0', '1', null),
('6', '3', 'shopImg', 'varchar', '店铺LOGO', '150', '0', '1', '', 'other', 'file', '0', '', '', '', '1', '0', '2019-03-28 18:18:01', '1', '0', '1', '1'),
('7', '3', 'goodsCatIds', 'varchar', '经营类目', '255', '0', '1', '', 'checkbox', 'custom', '0', '', '', '', '1', '0', '2019-03-28 18:30:43', '1', '0', '1', null),
('8', '3', 'shopQQ', 'varchar', '客服QQ', '50', '0', '1', '做为客服接收临时消息的QQ,需开通&lt;a target=&quot;_blank&quot; style=&quot;color:blue&quot; href=&quot;http://shang.qq.com/v3/index.html&quot;&gt;QQ推广功能&lt;/a&gt;  -&gt; 首页-&gt; 推广工具-&gt; 立即免费开通', 'input', '50', '0', '', '', '', '1', '0', '2019-03-28 18:32:04', '1', '0', '1', null),
('9', '3', 'shopWangWang', 'varchar', '阿里旺旺', '50', '0', '1', '', 'input', '50', '0', '', '', '', '1', '0', '2019-03-28 18:34:55', '1', '0', '1', null),
('10', '2', 'shopkeeper', 'varchar', '公司紧急联系人', '50', '0', '1', '', 'input', '50', '0', '', '', '', '1', '0', '2019-03-29 18:07:30', '1', '0', '1', null),
('11', '2', 'telephone', 'varchar', '公司紧急联系人手机', '20', '0', '1', '', 'input', '20', '0', '', '', '', '1', '0', '2019-03-29 18:08:46', '1', '0', '1', null),
('12', '2', 'businessLicenceType', 'tinyint', '执照类型', '4', '0', '1', '', 'select', '0||普通执照,1||多证合一营业执照(统一社会信用代码),2||多证合一营业执照(非统一社会信用代码)', '0', '', '', '', '1', '0', '2019-03-29 18:12:38', '1', '1', '0', null),
('13', '2', 'businessLicence', 'varchar', '营业执照注册号', '100', '0', '1', '', 'input', '100', '0', '', '', '', '1', '0', '2019-03-29 18:14:41', '1', '1', '0', null),
('14', '2', 'legalPersonName', 'varchar', '法定代表人姓名', '100', '0', '1', '', 'input', '100', '0', '', '', '', '1', '0', '2019-03-29 18:16:02', '1', '1', '0', null),
('15', '2', 'businessAreaPath', 'varchar', '营业执照所在地', '100', '0', '1', '', 'other', 'area', '0', '', '', '', '1', '0', '2019-03-29 18:41:29', '1', '1', '0', null),
('16', '2', 'licenseAddress', 'varchar', '营业执照详细地址', '500', '0', '1', '', 'input', '500', '0', '', '', '', '1', '0', '2019-03-29 18:52:01', '1', '1', '0', null),
('17', '2', 'establishmentDate', 'date', '成立日期', '20', '0', '1', '', 'other', 'date', '0', '', '', '', '1', '0', '2019-04-01 09:18:20', '1', '1', '0', null),
('18', '2', 'businessStartDate', 'date', '营业期限', '20', '0', '1', '', 'other', 'date', '0', '', 'businessEndDate,isLongbusinessDate,长期', '', '1', '0', '2019-04-01 09:23:04', '1', '1', '0', null),
('19', '2', 'businessEndDate', 'date', '营业期限', '20', '0', '1', '', 'other', 'date', '0', '', '', '', '0', '0', '2019-04-01 09:23:35', '1', '1', '0', null),
('20', '2', 'isLongbusinessDate', 'tinyint', '营业期限参数', '4', '0', '1', '', 'checkbox', '1||长期', '1', '', '', '', '0', '0', '2019-04-01 09:30:52', '1', '1', '0', null),
('21', '2', 'registeredCapital', 'decimal', '注册资本（万元）', '11', '0', '1', '', 'input', '11', '0', '', '', '', '1', '0', '2019-04-01 09:38:29', '1', '1', '0', null),
('22', '2', 'empiricalRange', 'varchar', '经营范围', '1000', '0', '1', '', 'textarea', '10,80', '0', '', '', '', '1', '0', '2019-04-01 09:42:06', '1', '1', '0', null),
('23', '2', 'legalCertificateType', 'tinyint', '法人代表证件类型', '4', '0', '1', '', 'select', '0||大陆身份证,1||护照,2||港澳居民通行证,3||台湾居民通行证', '0', '', '', '', '1', '0', '2019-04-01 10:00:57', '1', '1', '0', null),
('24', '2', 'legalCertificate', 'varchar', '法定代表人证件号', '50', '0', '1', '', 'input', '50', '0', '', '', '', '1', '0', '2019-04-01 10:02:13', '1', '1', '0', null),
('25', '2', 'legalCertificateStartDate', 'date', '法定代表人证件有效期', '20', '0', '1', '', 'other', 'date', '0', '', 'legalCertificateEndDate,isLonglegalCertificateDate,长期', '', '1', '0', '2019-04-01 10:03:22', '1', '1', '0', null),
('26', '2', 'legalCertificateEndDate', 'date', '法定代表人证件有效期', '20', '0', '1', '', 'other', 'date', '0', '', '', '', '0', '0', '2019-04-01 10:03:55', '1', '1', '0', null),
('27', '2', 'isLonglegalCertificateDate', 'tinyint', '法定代表人证件有效期参数', '4', '0', '1', '', 'checkbox', '1||长期', '0', '', '', '', '0', '0', '2019-04-01 10:05:11', '1', '1', '0', null),
('28', '2', 'legalCertificateImg', 'varchar', '法人证件电子版', '150', '0', '1', '', 'other', 'file', '0', '', '', '', '1', '0', '2019-04-01 10:07:48', '1', '1', '0', '1'),
('29', '2', 'businessLicenceImg', 'varchar', '营业执照电子版', '150', '0', '1', '', 'other', 'file', '0', '', '', '', '1', '0', '2019-04-01 10:09:15', '1', '1', '0', '1'),
('30', '2', 'bankAccountPermitImg', 'varchar', '银行开户许可证电子版', '150', '0', '1', '', 'other', 'file', '0', '', '', '', '1', '0', '2019-04-01 10:09:45', '1', '1', '0', '1'),
('31', '2', 'organizationCode', 'varchar', '组织机构代码', '100', '0', '1', '', 'input', '100', '0', '', '', '', '1', '0', '2019-04-01 10:10:28', '1', '1', '0', null),
('32', '2', 'organizationCodeStartDate', 'date', '组织机构代码证有效期', '20', '0', '1', '', 'other', 'date', '0', '', 'organizationCodeEndDate,isLongOrganizationCodeDate,长期', '', '1', '0', '2019-04-01 10:19:11', '1', '1', '0', null),
('33', '2', 'organizationCodeEndDate', 'date', '组织机构代码证有效期', '20', '0', '1', '', 'other', 'date', '0', '', '', '', '0', '0', '2019-04-01 10:29:24', '1', '1', '0', null),
('34', '2', 'isLongOrganizationCodeDate', 'tinyint', '组织机构代码证有效期参数', '4', '0', '1', '', 'checkbox', '1||长期', '0', '', '', '', '0', '0', '2019-04-01 10:30:29', '1', '1', '0', null),
('35', '2', 'organizationCodeImg', 'varchar', '组织机构代码证电子版', '150', '0', '1', '复印件需加盖公司红章扫描上传，三证合一的此处请上传营业执照电子版', 'other', 'file', '0', '', '', '', '1', '0', '2019-04-01 10:31:23', '1', '1', '0', '1'),
('36', '2', 'taxpayerType', 'tinyint', '纳税人类型', '4', '0', '1', '', 'select', '0||一般纳税人,1||小规模纳税人,2||非增值纳税人', '0', '', '', '', '1', '0', '2019-04-01 10:54:19', '1', '1', '0', null),
('37', '2', 'taxpayerNo', 'varchar', '纳税人识别号', '100', '0', '1', '三证合一的请填写统一社会信用代码', 'input', '100', '0', '', '', '', '1', '0', '2019-04-01 10:55:18', '1', '1', '0', null),
('38', '2', 'taxRegistrationCertificateImg', 'varchar', '税务登记证电子版', '450', '0', '1', '请同时上传国税、地税的税务登记证，两者缺一不可，复印件加盖公司红章，如贵司所在地区已推行“三证合一”，此处请上传营业执照副本电子版。【最多只能上传三张图片】', 'other', 'file', '0', '', '', '', '1', '0', '2019-04-01 10:59:17', '1', '1', '0', '3'),
('39', '2', 'taxpayerQualificationImg', 'varchar', '一般纳税人资格证电子版', '150', '0', '1', '三证合一地区请上传税务局网站上一般纳税人截图，复印件需加盖公司红章。', 'other', 'file', '0', '', '', '', '1', '0', '2019-04-01 11:00:32', '1', '1', '0', '1'),
('40', '2', 'applyLinkMan', 'varchar', '联系人姓名', '50', '0', '1', '', 'input', '50', '0', '', '', '', '1', '0', '2019-04-01 11:20:52', '1', '0', '0', null),
('41', '2', 'applyLinkTel', 'varchar', '联系人手机', '50', '0', '1', '', 'input', '50', '0', '', '', '', '1', '0', '2019-04-01 11:23:13', '1', '0', '0', null),
('42', '2', 'applyLinkEmail', 'varchar', '联系人电子邮箱', '50', '0', '1', '用于入驻过程中接收商城审核结果，请务必正确填写。', 'input', '50', '0', '', '', '', '1', '0', '2019-04-01 11:23:38', '1', '0', '0', null),
('43', '2', 'isInvestment', 'tinyint', '对接商城招商人员', '4', '0', '1', '如果没有联系过商城招商人员请选择“无”。', 'radio', '1||有,0||无', '1', 'investmentStaff', '', '', '1', '0', '2019-04-01 11:25:02', '1', '0', '0', null),
('44', '2', 'investmentStaff', 'varchar', '对接商城招商人员姓名', '50', '0', '1', '', 'input', '50', '1', 'isInvestment', '', '', '1', '0', '2019-04-01 11:25:50', '1', '0', '0', null),
('45', '2', 'bankUserName', 'varchar', '银行开户名', '50', '0', '1', '', 'input', '50', '0', '', '', '', '1', '0', '2019-04-01 11:33:42', '1', '0', '1', null),
('46', '2', 'bankNo', 'varchar', '对公结算银行账号', '20', '0', '1', '', 'input', '20', '0', '', '', '', '1', '0', '2019-04-01 11:34:49', '1', '0', '1', null),
('47', '2', 'bankId', 'int', '开户银行名称', '11', '0', '1', '', 'select', 'custom', '0', '', '', '', '1', '0', '2019-04-01 11:40:53', '1', '0', '1', null),
('48', '2', 'bankAreaIdPath', 'varchar', '开户银行支行所在地', '100', '0', '1', '', 'other', 'area', '0', '', '', '', '1', '0', '2019-04-01 11:41:30', '1', '0', '1', null),
('49', '3', 'isInvoice', 'tinyint', '是否提供发票', '4', '0', '1', '', 'radio', '1||是,0||否', '1', 'invoiceRemarks', '', '', '1', '0', '2019-04-01 14:09:18', '1', '0', '1', null),
('50', '3', 'invoiceRemarks', 'varchar', '发票说明', '255', '0', '1', '', 'input', '255', '1', 'isInvoice', '', '', '1', '0', '2019-04-01 14:10:57', '1', '0', '1', null),
('51', '3', 'shopAtive', 'tinyint', '营业状态', '4', '0', '1', '', 'radio', '1||营业中,0||休息中', '0', '', '', '', '1', '0', '2019-04-01 14:12:09', '1', '0', '1', null),
('53', '2', 'serviceStartTime', 'time', '服务时间', '20', '0', '1', '', 'other', 'time', '0', '', 'serviceEndTime', 'serviceEndTime', '1', '0', '2019-04-01 14:20:16', '1', '0', '1', null),
('54', '2', 'serviceEndTime', 'time', '服务时间', '20', '0', '1', '', 'other', 'time', '0', '', '', '', '0', '0', '2019-04-01 14:34:59', '1', '0', '1', null),
('55', '2', 'mapLevel', 'int', '地图等级', '11', '0', '1', '', 'input', '11', '0', '', '', '', '0', '0', '2019-04-02 18:35:53', '1', '0', '1', null),
('56', '2', 'longitude', 'decimal', '经度', '11', '0', '1', '', 'input', '255', '0', '', '', '', '0', '0', '2019-04-02 18:37:24', '1', '0', '1', null),
('57', '2', 'latitude', 'decimal', '纬度', '11', '0', '1', '', 'input', '255', '0', '', '', '', '0', '0', '2019-04-02 18:37:46', '1', '0', '1', null),
('58', '3', 'tradeId', 'int', '所属行业', '11', '2', '1', '', 'select', 'custom', '0', '', '', '', '1', '0', '2020-04-09 12:12:11', '1', '1', '1', '1');
