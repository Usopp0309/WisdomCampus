DROP TABLE IF EXISTS `palm_bluetooth_bracelet`;
CREATE TABLE `palm_bluetooth_bracelet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) DEFAULT NULL COMMENT '所属资产主键',
  `updateUserId` int(11) DEFAULT NULL COMMENT '更新人',
  `createTime` varchar(20) DEFAULT NULL COMMENT '创建时间',
  `code` varchar(50) DEFAULT NULL COMMENT '手环唯一编号',
  `status` int(1) DEFAULT NULL COMMENT '状态(0:未使用，1：停用，2：使用中，3：未归还)',
  `mac` varchar(100) DEFAULT NULL COMMENT '蓝牙手环地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COMMENT='蓝牙手环表';

DROP TABLE IF EXISTS `palm_bluetooth_course`;
CREATE TABLE `palm_bluetooth_course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL COMMENT '名称',
  `updateTime` varchar(20) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL COMMENT '创建人',
  `userName` varchar(255) DEFAULT NULL COMMENT '创建人名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COMMENT='蓝牙手环使用课程';

DROP TABLE IF EXISTS `palm_bluetooth_course_time`;
CREATE TABLE `palm_bluetooth_course_time` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bluetoothCourseId` int(11) DEFAULT NULL COMMENT '课程id',
  `startTime` varchar(20) DEFAULT NULL COMMENT '开始时间',
  `endTime` varchar(20) DEFAULT NULL COMMENT '结束时间',
  `userId` int(11) DEFAULT NULL COMMENT '创建人',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='手环使用课程时间';

DROP TABLE IF EXISTS `palm_bluetooth_data`;
CREATE TABLE `palm_bluetooth_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bluetoothBraceletId` int(11) DEFAULT NULL COMMENT '蓝牙手环主键',
  `createTime` varchar(20) DEFAULT NULL COMMENT '数据入库时间',
  `dataTime` varchar(20) DEFAULT NULL COMMENT '数据时间',
  `calorie` double(6,1) DEFAULT '0.0' COMMENT '卡路里',
  `heartRate` int(11) DEFAULT '0' COMMENT '心率(分/次)',
  `steps` int(11) DEFAULT '0' COMMENT '步数',
  `userId` int(11) DEFAULT NULL COMMENT '使用人',
  `realName` varchar(20) DEFAULT NULL COMMENT '使用人名称',
  `clazzId` int(11) DEFAULT NULL COMMENT '班级Id',
  `clazzName` varchar(255) DEFAULT NULL COMMENT '班级名称',
  `ip` varchar(50) DEFAULT NULL COMMENT '路由ip',
  `mac` varchar(100) DEFAULT NULL COMMENT '路由器的mac',
  `braceletMac` varchar(50) DEFAULT NULL COMMENT '蓝牙手环Mac地址',
  `bluetoothCourseTimeId` int(5) DEFAULT NULL COMMENT '蓝牙手环使用课程时间',
  `braceletCode` varchar(30) DEFAULT NULL COMMENT '蓝牙手环编号',
  `userCode` varchar(255) DEFAULT NULL COMMENT '学生学号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=315 DEFAULT CHARSET=utf8mb4 COMMENT='手环数据记录表';

DROP TABLE IF EXISTS `palm_bluetooth_router`;
CREATE TABLE `palm_bluetooth_router` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mac` varchar(50) DEFAULT NULL COMMENT '路由的mac',
  `code` varchar(50) DEFAULT NULL COMMENT '路由器编号',
  `status` int(1) DEFAULT NULL COMMENT '状态（0：正常，1：停用）',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `updateTime` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='蓝牙路由器表';

DROP TABLE IF EXISTS `palm_bluetooth_student`;
CREATE TABLE `palm_bluetooth_student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL COMMENT '学生userId',
  `updateTime` varchar(20) DEFAULT NULL COMMENT '数据更新时间',
  `bluetoothBraceletId` varchar(50) DEFAULT NULL COMMENT '手环主键',
  `clazzId` int(11) DEFAULT NULL COMMENT '班级',
  `updateUserId` int(11) DEFAULT NULL COMMENT '操作人',
  `clazzName` varchar(30) DEFAULT NULL COMMENT '班级名称',
  `studentName` varchar(30) DEFAULT NULL COMMENT '学生名称',
  `bluetoothCourseTimeId` int(5) DEFAULT NULL COMMENT '蓝牙手环使用课程时间',
  `userCode` varchar(30) DEFAULT NULL COMMENT '学号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COMMENT='蓝牙手环与学生关系表';

DROP TABLE IF EXISTS `palm_order_message_pay`;
CREATE TABLE `palm_order_message_pay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(1) DEFAULT NULL COMMENT '0：学校统一缴费 1：线上缴费',
  `createTime` varchar(20) DEFAULT NULL,
  `updateTime` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='服务费支付方式（学校统一缴费或线上缴费）';

INSERT INTO `palm_order_message_pay` VALUES ('1', '1', '2017-03-25 14:32:51', '2017-03-25 16:41:12');

DROP TABLE IF EXISTS `palm_order_message_card_deposit`;
CREATE TABLE `palm_order_message_card_deposit` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) DEFAULT NULL COMMENT '商品名',
  `realName` varchar(32) DEFAULT NULL COMMENT '用户姓名',
  `userId` int(11) DEFAULT NULL COMMENT '用户Id',
  `createTime` varchar(32) DEFAULT NULL COMMENT '创建时间',
  `updateTime` varchar(32) DEFAULT NULL COMMENT '更新时间',
  `orderId` int(11) DEFAULT NULL COMMENT '订单id',
  `status` int(1) DEFAULT NULL COMMENT '状态 0可用 1不可用',
  `messageId` int(11) DEFAULT NULL COMMENT '对应的套餐id',
  `replaceUserId` int(11) DEFAULT NULL COMMENT '代充人Id',
  `replaceRealName` varchar(32) DEFAULT NULL COMMENT '代充人姓名',
  `familyId` varchar(32) DEFAULT NULL COMMENT '家庭id',
  `count` int(11) DEFAULT NULL COMMENT '购买数量',
  `cardPrice` double DEFAULT NULL COMMENT '卡押金',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='用户卡押金支付记录';
DROP TABLE IF EXISTS `palm_abnormalinformation`;
CREATE TABLE `palm_abnormalinformation`
(
   id                   BIGINT NOT NULL AUTO_INCREMENT,
   content              TEXT COMMENT '信息内容',
   userId               INT(11) COMMENT '用户ID',
   createTime           DATETIME COMMENT '创建时间',
   TYPE                 INT(1) COMMENT '类型：0迟到 1早退',
   PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='异常信息表';
ALTER TABLE `palm_abnormalinformation` ADD INDEX `PK_USERID` (`userId`) ;

DROP TABLE IF EXISTS `palm_achievement`;
CREATE TABLE `palm_achievement` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userId` int(11) DEFAULT NULL COMMENT '用户id',
  `testType` varchar(12) DEFAULT NULL COMMENT '考试类型。例如：期中考试，期末考试',
  `subject` varchar(20) DEFAULT NULL COMMENT '考试科目',
  `score` varchar(10) DEFAULT NULL COMMENT '考试成绩',
  `clazzName` varchar(20) DEFAULT NULL COMMENT '班级名称',
  `gradeName` varchar(20) DEFAULT NULL COMMENT '年级名称',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `createUserId` int(11) DEFAULT NULL COMMENT '导入成绩人员',
   clazzId              int(11) default NULL comment '班级ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='作业或成绩下发表';

DROP TABLE IF EXISTS `palm_achievement_analysis`;
CREATE TABLE `palm_achievement_analysis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL COMMENT '用户id',
  `examId` int(11) NOT NULL COMMENT '考试ID',
  `subjectId` int(11) NOT NULL COMMENT '考试科目ID',
  `score` varchar(10) DEFAULT NULL COMMENT '考试成绩',
  `clazzName` varchar(20) DEFAULT NULL COMMENT '班级名称',
  `gradeName` varchar(20) DEFAULT NULL COMMENT '年级名称',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `createUserId` int(11) DEFAULT NULL COMMENT '导入成绩人员',
  `clazzId` int(11) DEFAULT NULL COMMENT '班级ID',
  `gradeId` int(11) DEFAULT NULL COMMENT '年级Id',
  `teacherId` int(11) DEFAULT NULL COMMENT '老师ID',
  `total` varchar(32) DEFAULT NULL COMMENT '科目总分',
  PRIMARY KEY (`id`),
  KEY `clazzId_examId` (`clazzId`,`examId`),
  KEY `gradeId` (`gradeId`),
  KEY `subjectId` (`subjectId`),
  KEY `userId` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=267 DEFAULT CHARSET=utf8mb4 COMMENT='成绩信息表-成绩云系统';

DROP TABLE IF EXISTS `palm_achievement_clazz_ranking`;
CREATE TABLE `palm_achievement_clazz_ranking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `achieveId` int(11) DEFAULT NULL COMMENT '单科成绩Id 为空时表示是总分的排名',
  `examScoreId` int(11) DEFAULT NULL COMMENT '考试总分Id 为空时表示是单科的排名',
  `ranking` int(11) DEFAULT NULL COMMENT '排名',
  `type` int(11) DEFAULT NULL COMMENT '上升1 下降2 和上次一样0',
  `upOrDown` int(11) DEFAULT NULL COMMENT '下降上升多少名',
  `userId` int(11) DEFAULT NULL COMMENT '学生ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COMMENT='个人班级排名表-成绩云系统';

DROP TABLE IF EXISTS `palm_achievement_grade_ranking`;
CREATE TABLE `palm_achievement_grade_ranking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `achieveId` int(11) DEFAULT NULL COMMENT '单科成绩Id 为空时表示是总分的排名',
  `examScoreId` int(11) DEFAULT NULL COMMENT '考试总分Id 为空时表示是单科的排名',
  `ranking` int(11) DEFAULT NULL COMMENT '排名',
  `type` int(11) DEFAULT NULL COMMENT '上升1 下降2 和上次一样0',
  `upOrDown` int(11) DEFAULT NULL COMMENT '下降上升多少名',
  `userId` int(11) DEFAULT NULL COMMENT '学生Id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COMMENT='个人年级排名表-成绩云系统';

DROP TABLE IF EXISTS `palm_address_list`;
CREATE TABLE `palm_address_list` (
  `listId` int(11) NOT NULL AUTO_INCREMENT,
  `menuId` varchar(32) DEFAULT NULL COMMENT '通讯录id',
  `menuName` varchar(32) DEFAULT NULL COMMENT '通讯录名称',
  `status` int(11) DEFAULT NULL COMMENT '状态 1使用  2不使用',
  PRIMARY KEY (`listId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='通讯录';
INSERT INTO `palm_address_list` VALUES (1,'schoolAddress','学校通讯录',1);
INSERT INTO `palm_address_list` VALUES (2,'classAddress','班级通讯录',1);

DROP TABLE IF EXISTS `palm_announcement`;
CREATE TABLE `palm_announcement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(1000) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `apic` varchar(255) DEFAULT NULL,
  `clazzId` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '1:学校公告 2:部门公告3:班级公告4:系统公告',
  `departmentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='公告表';
ALTER TABLE `palm_announcement` ADD INDEX `PK_USERID` (`userId`);

DROP TABLE IF EXISTS `palm_app_home_page`;
CREATE TABLE `palm_app_home_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menuId` varchar(255) DEFAULT NULL COMMENT '菜单id',
  `menuType` int(11) DEFAULT NULL COMMENT '菜单顺序',
  `menuStatus` int(11) DEFAULT NULL COMMENT '菜单的位置 1 表示页面中间的四个  2表示页面下面的八个',
  `menuName` varchar(32) DEFAULT NULL COMMENT '菜单的名称',
  `menuUrl` varchar(255) DEFAULT NULL,
  `menuIcon` varchar(100) DEFAULT NULL,
  `permissionCode` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='APP首页菜单配置功能表';

DROP TABLE IF EXISTS `palm_asset`;
CREATE TABLE `palm_asset` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` varchar(32) DEFAULT NULL COMMENT '资产编码',
  `name` varchar(32) DEFAULT NULL COMMENT '资产名称',
  `manufacturer` varchar(32) DEFAULT NULL COMMENT '厂商名称',
  `type` int(1) DEFAULT '0' COMMENT '资产类型',
  `property` int(1) DEFAULT '0' COMMENT '0学校资产 1个人资产',
  `spec` varchar(32) DEFAULT NULL COMMENT '资产规格',
  `model` varchar(32) DEFAULT NULL COMMENT '资产型号',
  `units` varchar(32) DEFAULT NULL COMMENT '计数单位 台、个、等',
  `count` int(11) DEFAULT NULL COMMENT '数量',
  `price` double DEFAULT NULL COMMENT '单价',
  `site` varchar(32) DEFAULT NULL COMMENT '存放位置',
  `buyDate` varchar(32) DEFAULT NULL COMMENT '购买日期',
  `qualityDate` varchar(32) DEFAULT NULL COMMENT '保质期',
  `totalPrice` double DEFAULT NULL COMMENT '资产总价',
  `respPersonId` int(11) DEFAULT NULL COMMENT '负责人ID',
  `respPerson` varchar(32) DEFAULT NULL COMMENT '负责人姓名',
  `receiveId` int(11) DEFAULT NULL COMMENT '领取人ID',
  `receiveTime` varchar(32) DEFAULT NULL COMMENT '领取时间',
  `remark` varchar(1000) DEFAULT NULL COMMENT '资产描述',
  `createTime` varchar(32) DEFAULT NULL COMMENT '创建时间',
  `updateTime` varchar(32) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='资产表';

DROP TABLE IF EXISTS `palm_asset_import`;
CREATE TABLE `palm_asset_import` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `fileName` varchar(32) DEFAULT NULL COMMENT '文件名称',
  `userId` int(11) DEFAULT NULL COMMENT '导入人ID',
  `realName` varchar(32) DEFAULT NULL COMMENT '导入人',
  `total` int(11) DEFAULT '0' COMMENT '总条数',
  `success` int(11) DEFAULT '0' COMMENT '成功数量',
  `error` int(11) DEFAULT '0' COMMENT '失败数量',
  `createTime` varchar(32) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='资产导入信息表';

DROP TABLE IF EXISTS `palm_asset_repair`;
CREATE TABLE `palm_asset_repair` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `assetId` int(11) DEFAULT NULL COMMENT '资产Id',
  `userId` int(11) DEFAULT NULL COMMENT '报修人ID',
  `realName` varchar(32) DEFAULT NULL COMMENT '报修人',
  `phone` varchar(32) DEFAULT NULL COMMENT '联系方式',
  `type` int(11) DEFAULT NULL COMMENT '报修类型',
  `servicemanId` int(11) DEFAULT NULL COMMENT '维修人员Id',
  `price` double DEFAULT NULL COMMENT '报修价格',
  `repairPrice` double DEFAULT NULL COMMENT '维修估计',
  `status` int(2) DEFAULT NULL COMMENT '状态:0待处理 1已领取工单 2已同意维修 3已拒绝维修 4维修完成',
  `remark` varchar(1000) DEFAULT NULL COMMENT '问题描述',
  `auditRemark` varchar(1000) DEFAULT NULL COMMENT '审核意见',
  `estimatedTime` varchar(32) DEFAULT NULL COMMENT '预计完成时间',
  `createTime` varchar(32) DEFAULT NULL COMMENT '创建时间',
  `receiveTime` varchar(32) DEFAULT NULL COMMENT '领取时间',
  `auditTime` varchar(32) DEFAULT NULL COMMENT '审核时间',
  `finishTime` varchar(32) DEFAULT NULL COMMENT '完成时间',
  `updateTime` varchar(32) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='资产维修表';

DROP TABLE IF EXISTS `palm_asset_repair_img`;
CREATE TABLE `palm_asset_repair_img` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `repairId` int(11) DEFAULT NULL COMMENT '维修ID',
  `path` varchar(255) DEFAULT NULL COMMENT '图片路劲',
  `name` varchar(32) DEFAULT NULL COMMENT '图片名称',
  `createTime` varchar(32) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='维修图片表';

DROP TABLE IF EXISTS `palm_asset_serviceman`;
CREATE TABLE `palm_asset_serviceman` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `servicemanId` int(11) DEFAULT NULL COMMENT '维修人员Id（或安全隐患检查人员）',
  `serviceman` varchar(32) DEFAULT NULL COMMENT '维修人员（或安全隐患检查人员）',
  `phone` varchar(32) DEFAULT NULL COMMENT '联系方式',
  `code` varchar(32) DEFAULT NULL COMMENT '员工编号',
  `type` int(11) DEFAULT NULL COMMENT '安全隐患类型为（-1，-2）,其他类型为维修类型',
  `leaderIdOne` int(11) DEFAULT NULL COMMENT '负责人1Id（安全隐患检查人员不存在领导）',
  `leaderOne` varchar(32) DEFAULT NULL COMMENT '负责人1（安全隐患检查人员不存在领导）',
  `leaderIdTwo` int(11) DEFAULT NULL COMMENT '负责人2Id（安全隐患检查人员不存在领导）',
  `leaderTwo` varchar(32) DEFAULT NULL COMMENT '负责人1（安全隐患检查人员不存在领导）',
  `createTime` varchar(32) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8mb4 COMMENT='资产维修人员列表（或安全隐患检查人员列表）';

DROP TABLE IF EXISTS `palm_security_danger`;
CREATE TABLE `palm_security_danger` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(2) DEFAULT '0' COMMENT '0：其它，1：学生行为，2：学校资产',
  `desc` varchar(1000) DEFAULT NULL COMMENT '隐患描述',
  `createUserId` int(11) DEFAULT NULL COMMENT '上报人',
  `createTime` varchar(20) DEFAULT NULL COMMENT '上报时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='安全隐患排查';


DROP TABLE IF EXISTS `palm_security_danger_attachment`;
CREATE TABLE `palm_security_danger_attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parentId` int(11) DEFAULT NULL COMMENT '安全隐患表主键',
  `url` varchar(250) DEFAULT NULL COMMENT '附件路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='安全隐患附件表';


DROP TABLE IF EXISTS `palm_security_danger_detail`;
CREATE TABLE `palm_security_danger_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receive` int(11) DEFAULT NULL COMMENT '接收人',
  `parentId` int(11) DEFAULT NULL COMMENT '安全隐患表主键',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `palm_camera`;
CREATE TABLE `palm_camera` (
  `cameraId` INT(11) NOT NULL AUTO_INCREMENT COMMENT '摄像头Id',
  `cameraCode` VARCHAR(255) DEFAULT NULL COMMENT '摄像头编码',
  `password` VARCHAR(255) DEFAULT NULL COMMENT '摄像头密码',
  `status` INT(1) DEFAULT NULL COMMENT '工作状态 1工作 2关闭(预留字段)',
  `placeId` INT(11) DEFAULT NULL COMMENT '对应的地点Id',
  `createTime` VARCHAR(32) DEFAULT NULL COMMENT '创建时间',
  `updateTime` VARCHAR(32) DEFAULT NULL COMMENT '修改时间',
  `cameraName` VARCHAR(255) DEFAULT NULL COMMENT '摄像头名称',
  `type` INT(1) DEFAULT '2' COMMENT '0 班级使用  1 表示需交费才可以查看 2全校',
  `startDay` VARCHAR(32) DEFAULT NULL COMMENT '开始日期',
  `endDay` VARCHAR(32) DEFAULT NULL COMMENT '结束日期',
  `startTime` VARCHAR(32) DEFAULT NULL COMMENT '开始时间',
  `endTime` VARCHAR(32) DEFAULT NULL COMMENT '结束时间',
  PRIMARY KEY (`cameraId`)
) ENGINE=INNODB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COMMENT='摄像头'

DROP TABLE IF EXISTS `palm_camera_clazz`;
CREATE TABLE `palm_camera_clazz` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clazzId` int(11) DEFAULT NULL COMMENT '班级Id',
  `cameraId` int(11) DEFAULT NULL COMMENT '摄像头id',
  `createTime` varchar(32) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COMMENT='摄像头和班级的关系';

DROP TABLE IF EXISTS `palm_camera_user`;
CREATE TABLE `palm_camera_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL COMMENT '学生id',
  `cameraId` int(11) DEFAULT NULL COMMENT '摄像头Id',
  `createTime` varchar(32) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COMMENT='摄像头和人员的关系';

DROP TABLE IF EXISTS `palm_card`;
CREATE TABLE `palm_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cardCode` varchar(32) DEFAULT NULL COMMENT '卡号',
  `status` int(11) DEFAULT '1' COMMENT '卡的状态：0 停用 1在用 2失效 等等 暂时保留',
  `battery` int(11) DEFAULT NULL COMMENT '暂时保留 ',
  `updateTime` datetime DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='用户卡表,用于存储用户的卡号';

DROP TABLE IF EXISTS `palm_check`;
CREATE TABLE `palm_check` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `period` int(11) DEFAULT NULL COMMENT '每个线程都有一个唯一的period',
  `content` varchar(1024) DEFAULT NULL COMMENT '一个线程一个内容',
  `checkTime` datetime DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='检测线程记录表,记录当前线程在当天当前时间段是否统计';

DROP TABLE IF EXISTS `palm_checkattendance`;
CREATE TABLE `palm_checkattendance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `departmentId` int(11) DEFAULT NULL COMMENT '部门id(该表中是教职工的人才能有部门id)',
  `clazzId` int(11) DEFAULT NULL COMMENT '班级id(只有学生有班级id)',
  `status` int(11) DEFAULT NULL COMMENT '刷卡状态，1 : 上午旷工 2 : 上午迟到  3 : 上午早退 4 : 上午正常下班   5 : 上午下班正常   8 : 下午旷工  9 : 下午迟到  10 : 下午早退  11 下午正常上班 12下午正常下班  参考palm_checkattendance_order表主键',
  `remark` varchar(32) DEFAULT NULL COMMENT '用来记录：考勤补录 病假等',
  `type` int(11) DEFAULT NULL COMMENT '师生类型 ： 0 教师 1 学生',
  `createDate` date DEFAULT NULL COMMENT '当天的日期',
  `createTime` datetime DEFAULT NULL COMMENT '数据生成的时间',
  `inoutTime` datetime DEFAULT NULL COMMENT '刷卡的时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='师生考勤表,用于查询师生考勤状态';
ALTER TABLE `palm_checkattendance` ADD INDEX `PK_USERID` (`userId`) ;

DROP TABLE IF EXISTS `palm_checkattendance_order`;
CREATE TABLE `palm_checkattendance_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id和checkattendance表中的status字段对应',
  `orderStyle` int(11) DEFAULT NULL,
  `statusName` varchar(32) DEFAULT NULL,
  `status` int(1) DEFAULT NULL COMMENT '是否启用： 0 启用 1禁用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COMMENT='师生考勤排序表,仅用于师生考考勤表的排序';
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('1', '0', '上午旷工', '0');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('2', '1', '上午迟到', '0');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('3', '3', '上午早退', '0');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('4', '4', '上午正常下班', '0');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('5', '2', '上午正常上班', '0');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('6', '5', '上午非正常进校', '1');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('7', '6', '上午非正常出校', '1');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('8', '11', '下午旷工', '0');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('9', '8', '下午迟到', '0');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('10', '9', '下午早退', '0');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('11', '7', '下午正常上班', '0');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('12', '10', '下午正常下班', '0');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('13', '12', '下午非正常进校', '1');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('14', '13', '下午非正常出校', '1');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('15', '14', '晚上旷工', '1');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('16', '15', '晚上迟到', '1');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('17', '16', '晚上早退', '1');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('18', '17', '晚上正常上班', '1');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('19', '18', '晚上正常下班', '1');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('20', '19', '晚上非正常进校', '1');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('21', '20', '晚上非正常出校', '1');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('22', '21', '正常上班', '0');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('23', '22', '迟到', '0');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('24', '23', '早退', '0');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('25', '24', '正常下班', '0');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('26', '25', '旷工', '0');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('27', '26', '非正常进校', '1');
INSERT INTO `palm_checkattendance_order`(id, orderStyle, statusName, status) VALUES ('28', '27', '非正常出校', '1');

DROP TABLE IF EXISTS `palm_class_photo_album`;
CREATE TABLE `palm_class_photo_album` (
  `albumId` INT(11) NOT NULL AUTO_INCREMENT COMMENT '相册id主键',
  `albumName` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '相册名称',
  `albumDesc` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '相册描述',
  `createUserId` INT(11) DEFAULT NULL COMMENT '创建人id',
  `createUserName` VARCHAR(32) DEFAULT NULL COMMENT '创建人姓名',
  `clazzId` INT(11) DEFAULT NULL COMMENT '相册所属班级',
  `clazzName` VARCHAR(32) DEFAULT NULL COMMENT '相册所属班级名称',
  `createTime` VARCHAR(32) DEFAULT NULL COMMENT '相册创建时间',
  `updateTime` VARCHAR(32) DEFAULT NULL COMMENT '相册更新时间',
  `albumPath` VARCHAR(255) DEFAULT NULL COMMENT '相册封面地址',
  PRIMARY KEY (`albumId`)
) ENGINE=INNODB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COMMENT='班级相册变以班级为单位  一个班级可以有多个相册';

DROP TABLE IF EXISTS `palm_classroom`;
CREATE TABLE `palm_classroom` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id和palm_curriculum表中的classroomId字段对应',
  `code` varchar(32) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教室表，仅用于课程表教室选择';

DROP TABLE IF EXISTS `palm_clazz`;
CREATE TABLE `palm_clazz` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '班级表主键',
  `clazzName` varchar(64) NOT NULL COMMENT '班级名称（3班）',
  `leaderId` int(11) DEFAULT NULL COMMENT '班主任id',
  `updateTime` datetime DEFAULT NULL COMMENT '班级更新时间',
  `createTime` datetime DEFAULT NULL COMMENT '班级创建时间',
  `gradeId` int(11) DEFAULT NULL COMMENT '年级ID',
  `code` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `un_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='班级表';

DROP TABLE IF EXISTS `palm_curriculum`;
CREATE TABLE `palm_curriculum` (
   `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT '0' COMMENT '类型控制',
  `clazzId` int(11) DEFAULT NULL COMMENT '班级Id',
  `subjectName` varchar(32) DEFAULT NULL COMMENT '课程名称',
  `userId` int(11) DEFAULT NULL COMMENT '创建 导入人的ID',
  `subjectsUser` int(11) DEFAULT NULL COMMENT '代课人Id',
  `timeId` int(11) DEFAULT NULL COMMENT '时间段Id  和palm_curriculum_time表Id关联',
  `weekId` int(11) DEFAULT NULL COMMENT '星期Id  和palm_week表 Id关联',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `classroomId` int(11) DEFAULT NULL COMMENT '教室Id 和palm_classroom表Id关联',
  `semesterId` int(11) DEFAULT NULL COMMENT '对应的学期Id  和palm_curriculum_semester表 Id关联',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='课程表  每个班对应的科目 和代课教师';

DROP TABLE IF EXISTS `palm_curriculum_semester`;
CREATE TABLE `palm_curriculum_semester` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `beginDate` date DEFAULT NULL COMMENT '开始日期',
  `endDate` date DEFAULT NULL COMMENT '结束日期',
  `clazzId` int(11) DEFAULT NULL COMMENT '班级Id 幼儿园版本使用',
  `usable` int(2) DEFAULT NULL COMMENT ' 1 可用 2 不可用',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='学期表和课程时间表关联';

DROP TABLE IF EXISTS `palm_curriculum_time`;
CREATE TABLE `palm_curriculum_time` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `beginTime` time DEFAULT NULL COMMENT '课程开始时间',
  `endTime` time DEFAULT NULL COMMENT '课程结束时间',
  `semesterId` int(11) DEFAULT NULL COMMENT '对应的学期Id   和 palm_curriculum_semester表Id关联',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `num` int(1) DEFAULT NULL COMMENT '表示上下午  1上午  2下午 3 晚上 4早晨 5中午',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COMMENT='设置课程开始结束时间段';

DROP TABLE IF EXISTS `palm_department`;
CREATE TABLE `palm_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '部门表主键',
  `departmentName` varchar(50) NOT NULL COMMENT '部门名称',
  `updateTime` datetime DEFAULT NULL COMMENT '部门更新时间',
  `createTime` datetime DEFAULT NULL COMMENT '部门创建时间',
  `code` varchar(20) DEFAULT NULL COMMENT '部门编号',
  `leaderId` int(11) DEFAULT NULL COMMENT '部门领导id',
  `isAttendance`  varchar(1) DEFAULT 0 COMMENT '是否参与考勤 0是 1否',
  PRIMARY KEY (`id`,`departmentName`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='部门表';
INSERT INTO `palm_department` VALUES (0, '教职工未分组', '2015-11-26 17:09:17', '2015-11-26 17:09:19', null, null,0);
UPDATE palm_department SET id=0;

DROP TABLE IF EXISTS `palm_device`;
CREATE TABLE `palm_device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL,
  `ip` varchar(64) NOT NULL,
  `inoutType` int(11) DEFAULT NULL COMMENT '进出类型 1 进 2 出',
  `positionType` int(11) DEFAULT NULL COMMENT '设备类型 1 校门 2 宿舍  3 会议 4校车  后续如需要可以继续加类型',
  `placeId` int(11) DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  `createTime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `palm_position_index` (`ip`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='设备表,存储设备  与地点有关  几个设备号可以关联一个地点  一个设备不可有多个地点';

DROP TABLE IF EXISTS `palm_device_monitor`;
CREATE TABLE `palm_device_monitor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT ' 1工作状态 2 关闭',
  `threadId` varchar(32) DEFAULT NULL,
  `createTime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='设备表监控表';

DROP TABLE IF EXISTS `palm_dish`;
CREATE TABLE `palm_dish` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `recipeId` INT(11) NOT NULL COMMENT '食谱id',
  `dishType` VARCHAR(1) DEFAULT NULL COMMENT '菜品类型(1、早餐 2、午餐 3、下午茶4、其他)',
  `createTime` DATETIME DEFAULT NULL COMMENT '创建时间',
  `dishName` VARCHAR(255) DEFAULT NULL COMMENT '菜品名称',
  `picName` VARCHAR(255) DEFAULT NULL COMMENT '菜品图片名称',
  `picPath` VARCHAR(255) DEFAULT NULL COMMENT '菜品图片路径',
  `praiseCount` INT(11) DEFAULT '0' COMMENT '点赞次数',
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='菜品详情';

DROP TABLE IF EXISTS `palm_dormitory_abnormal`;
CREATE TABLE `palm_dormitory_abnormal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(96) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '1未正常进(未归)  2未正常出（未出）',
  `message` varchar(768) DEFAULT NULL,
  `sentTime` datetime DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='宿舍打卡异常统计表，跟据宿舍进出记录表 判断是否正常进出宿舍   异常指该出宿舍的时候没有出该进的时候没有进';

DROP TABLE IF EXISTS `palm_dormitory_abnormal_detail`;
CREATE TABLE `palm_dormitory_abnormal_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `time` varchar(100) DEFAULT NULL COMMENT '格式是yyyy-mm-dd  用于判定是那一天的',
  `gradeId` int(11) DEFAULT NULL,
  `clazzId` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '0:出宿舍 1:进宿舍',
  `positionId` int(11) DEFAULT NULL,
  `positionTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='宿舍异常详情表,此表用于存储异常详情表 用于宿舍统计  显示具体的人员信息';

DROP TABLE IF EXISTS `palm_dormitory_inout`;
CREATE TABLE `palm_dormitory_inout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '1进 2出',
  `position` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `sync` tinyint(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='宿舍打卡进出记录表,存储进出宿舍打卡信息记录表';
ALTER TABLE `palm_dormitory_inout` ADD INDEX `PK_USERID` (`userId`) ;

DROP TABLE IF EXISTS `palm_dynamic_graph`;
CREATE TABLE `palm_dynamic_graph` (
  `graphId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id 主键',
  `type` int(1) DEFAULT NULL COMMENT '类型 1校园LOGO 2园所新闻 3校园活动 4招生信息',
  `title` varchar(1000) DEFAULT NULL COMMENT '标题',
  `url` varchar(1000) DEFAULT NULL COMMENT '连接地址',
  `desc` varchar(255) DEFAULT NULL COMMENT '描述 预留',
  `status` int(1) DEFAULT NULL COMMENT '状态 1在用 2 不用',
  `path` varchar(1000) DEFAULT NULL COMMENT '图片路径',
  `userId` int(11) DEFAULT NULL COMMENT '上传者id',
  `realName` varchar(32) DEFAULT NULL COMMENT '上传者',
  `count` int(11) DEFAULT NULL COMMENT '预留',
  `createTime` varchar(32) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`graphId`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COMMENT='APP首页广告图';

DROP TABLE IF EXISTS `palm_evaluate_clazz_model`;
CREATE TABLE `palm_evaluate_clazz_model` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluatetimeId` int(11) DEFAULT NULL,
  `teachingfolderId` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `userType` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `palm_evaluate_detail_model`;
CREATE TABLE `palm_evaluate_detail_model` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titleId` int(11) DEFAULT NULL COMMENT '评价标题ID',
  `text` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `level` int(11) DEFAULT NULL COMMENT '给予老师评价等级',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='学生对老师评价选项详情表(模型)';

DROP TABLE IF EXISTS `palm_evaluate_form_model`;
CREATE TABLE `palm_evaluate_form_model` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '评价名称',
  `gradeId` int(10) DEFAULT NULL COMMENT '嫡属于年级',
  `clazzId` int(10) DEFAULT NULL COMMENT '嫡属于班级',
  `type` varchar(255) DEFAULT NULL COMMENT '分类',
  `userId` int(11) DEFAULT NULL,
  `sid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生对老师评价信息表单表(模型)';

DROP TABLE IF EXISTS `palm_evaluate_kindergarten`;
CREATE TABLE `palm_evaluate_kindergarten` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `teacherId` INT(11) NOT NULL COMMENT '教师id，评论人id',
  `studentId` INT(11) NOT NULL COMMENT '学生id，被评论人id',
  `createTime` VARCHAR(256) DEFAULT NULL COMMENT '创建时间',
  `characterStar` VARCHAR(1) DEFAULT NULL COMMENT '品德星级',
  `character` VARCHAR(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '品德评价',
  `sportStar` VARCHAR(1) DEFAULT NULL COMMENT '体育星级',
  `sport` VARCHAR(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '体育评价',
  `studyStar` VARCHAR(1) DEFAULT NULL COMMENT '学习星级',
  `study` VARCHAR(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '学习评价',
  `lifeStar` VARCHAR(1) DEFAULT NULL COMMENT '生活星级',
  `life` VARCHAR(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生活评价',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COMMENT='幼儿班教师对学生评价';

DROP TABLE IF EXISTS `palm_evaluate_phrase_model`;
CREATE TABLE `palm_evaluate_phrase_model` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `formId` int(11) DEFAULT NULL COMMENT '评价表单表ID',
  `titleId` int(11) DEFAULT NULL COMMENT '评价标题ID',
  `text` varchar(999) DEFAULT NULL COMMENT '对老师评价的常用短语',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生对老师评价短语表(模型)';

DROP TABLE IF EXISTS `palm_evaluate_title_model`;
CREATE TABLE `palm_evaluate_title_model` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `formId` int(11) DEFAULT NULL COMMENT '评价表单表ID',
  `title` varchar(255) DEFAULT NULL COMMENT '评价标题',
  `formType` varchar(255) DEFAULT NULL COMMENT '表单分类(单选/复选/文本框)',
  `contextType` varchar(255) DEFAULT NULL COMMENT '内容分类(教学水平等)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生对老师评价信息标题表(模型)';

DROP TABLE IF EXISTS `palm_evaluation_time`;
CREATE TABLE `palm_evaluation_time` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `startTime` date DEFAULT NULL COMMENT '评论开始时间',
  `endTime` date DEFAULT NULL COMMENT '评论结束时间',
  `clazzId` int(11) DEFAULT NULL COMMENT '允许评论班级',
  `gradeId` int(11) DEFAULT NULL COMMENT '允许评论年级',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='评价时间设定表';

DROP TABLE IF EXISTS `palm_exam_clazz`;
CREATE TABLE `palm_exam_clazz` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `examId` int(11) DEFAULT NULL COMMENT '考试Id',
  `clazzId` int(11) DEFAULT NULL COMMENT '班级Id 如果为0 则为gradeId下的所有班级',
  `gradeId` int(11) DEFAULT NULL COMMENT '年级Id 如果为0则表示所有的年级',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COMMENT='本次考试对应班级表';

DROP TABLE IF EXISTS `palm_examinationinfo`;
CREATE TABLE `palm_examinationinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '考试名称',
  `examStartTime` date NOT NULL COMMENT '考试结束日期',
  `examEndTime` date NOT NULL COMMENT '考试开始日期',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态 0启用 1禁用',
  `type` tinyint(4) DEFAULT NULL COMMENT '考试类型 0 单元测试 1 期中考试 2 期末考试 3 小升初 4 模拟考 5 中考 6  高考 7 月考',
  `term` varchar(32) DEFAULT NULL COMMENT '学期',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `isUnifiedExam` int(4) DEFAULT NULL COMMENT '是否为市级统考 1是 2否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='考试基本信息表';


DROP TABLE IF EXISTS `palm_examscore`;
CREATE TABLE `palm_examscore` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `examId` int(11) NOT NULL COMMENT '考试ID',
  `userId` int(11) NOT NULL COMMENT '学生ID',
  `score` varchar(32) DEFAULT NULL COMMENT '总分',
  `totalScore` varchar(32) NOT NULL COMMENT '满分',
  `clazzName` varchar(20) DEFAULT NULL COMMENT '班级名称',
  `gradeName` varchar(20) DEFAULT NULL COMMENT '年级名称',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `clazzId` int(11) DEFAULT NULL COMMENT '班级ID',
  `gradeId` int(11) DEFAULT NULL COMMENT '年级Id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COMMENT='考试总分表';

DROP TABLE IF EXISTS `palm_examsubjectinfo`;
CREATE TABLE `palm_examsubjectinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subjectName` varchar(50) NOT NULL COMMENT '科目名称',
  `fullMark` int(11) NOT NULL DEFAULT '100' COMMENT '满分',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COMMENT='考试科目信息表';

DROP TABLE IF EXISTS `palm_grade`;
CREATE TABLE `palm_grade` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '年级id',
  `leaderId` int(11) DEFAULT NULL COMMENT '年级主任id',
  `updateTime` datetime DEFAULT NULL COMMENT '年级更新时间',
  `createTime` datetime DEFAULT NULL COMMENT '年级创建时间',
  `createYear` varchar(50) DEFAULT NULL COMMENT '入学年份(201509),不能修改',
  `type` char(1) DEFAULT NULL COMMENT '年级所属类: 0 幼儿园 1小学 2 初中 3 高中',
  `state` char(1) DEFAULT '0' COMMENT '年级是否可用 ： 0 可用 1 不可用',
  `name` varchar(50) DEFAULT NULL COMMENT '年级名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='年级表';

DROP TABLE IF EXISTS `palm_growthcontent`;
CREATE TABLE `palm_growthcontent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `growthId` int(11) NOT NULL COMMENT '成长档案ID',
  `firstImgPath` varchar(200) DEFAULT NULL COMMENT '第一张图路径',
  `secondImgPath` varchar(200) DEFAULT NULL COMMENT '第二张图路径',
  `thirdImgPath` varchar(200) DEFAULT NULL COMMENT '第三张图路径',
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `createrId` int(11) DEFAULT NULL COMMENT '创建者ID',
  `type` int(11) DEFAULT NULL COMMENT '类型 0 开心的一天 1 我的作品 2 亲子活动 3 我的幼儿园 4 教学活动 5 童言 6 父母寄语',
  `content` varchar(500) DEFAULT NULL COMMENT '内容',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COMMENT='档案内容';

DROP TABLE IF EXISTS `palm_growthtemplate`;
CREATE TABLE `palm_growthtemplate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '模板名称',
  `path` varchar(255) NOT NULL COMMENT '模板所在目录',
  `createTime` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='成长档案模板表';
INSERT INTO `palm_growthtemplate` VALUES ('1', '模板1', 'images1', '2016-04-18 17:08:20');
INSERT INTO `palm_growthtemplate` VALUES ('2', '模板2', 'images2', '2016-04-18 17:10:30');
INSERT INTO `palm_growthtemplate` VALUES ('3', '模板3', 'images3', '2016-04-18 17:08:20');
INSERT INTO `palm_growthtemplate` VALUES ('4', '模板4', 'images4', '2016-04-18 17:10:30');
INSERT INTO `palm_growthtemplate` VALUES ('5', '模板5', 'images5', '2016-04-18 17:08:20');
INSERT INTO `palm_growthtemplate` VALUES ('6', '模板6', 'images6', '2016-04-18 17:10:30');

DROP TABLE IF EXISTS `palm_import`; 
CREATE TABLE `palm_import` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `filename` VARCHAR(64) NOT NULL,
  `type` INT(1) NOT NULL DEFAULT '0' COMMENT '0:导入学生家长 1:导入教师',
  `total` INT(11) NOT NULL DEFAULT '0' COMMENT '总条数',
  `success` INT(11) NOT NULL DEFAULT '0' COMMENT '成功导入条数',
  `error` INT(11) NOT NULL DEFAULT '0' COMMENT '未成功导入条数',
  `status` INT(1) NOT NULL DEFAULT '0' COMMENT '状态 0:未清空导入人员 1:已清空导入人员',
  `updateTime` DATETIME NOT NULL,
  `createTime` DATETIME NOT NULL,
  `importUserId` INT(11) DEFAULT NULL COMMENT '导入操作人员',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COMMENT='导入记录表,记录 家长学生教师等 导入信息';

DROP TABLE IF EXISTS `palm_import_detail`; 
CREATE TABLE `palm_import_detail` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `importId` INT(11) NOT NULL COMMENT '导入表主键',
  `userId` INT(11) DEFAULT '0' COMMENT '导入成功人员的userId',
  `phone` VARCHAR(32) DEFAULT '0' COMMENT '手机号',
  `code` VARCHAR(32) DEFAULT NULL COMMENT '学号或者工号',
  `realName` VARCHAR(32) DEFAULT NULL COMMENT '真实姓名',
  `roleCode` VARCHAR(32) DEFAULT NULL COMMENT '身份',
  `cardCode` VARCHAR(32) DEFAULT NULL COMMENT '卡号',  
  `clazzId` INT(11) DEFAULT '0' COMMENT '班级ID',
  `clazzName` VARCHAR(32) DEFAULT NULL COMMENT '班级名称',
  `departmentId` INT(11) DEFAULT '0' COMMENT '部门ID',
  `departmentName` VARCHAR(32) DEFAULT NULL COMMENT '部门名称',
  `status` INT(1) DEFAULT NULL COMMENT '状态0:成功 1:失败',
  `familyId` VARCHAR(32) DEFAULT NULL COMMENT '家庭Id,导入教师的时候该字段没有值',
  `updateTime` DATETIME NOT NULL,
  `createTime` DATETIME NOT NULL,
  `result` VARCHAR(255) DEFAULT NULL COMMENT '导入错误结果',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COMMENT='导入记录详情表,记录 家长学生教师等 导入信息';

DROP TABLE IF EXISTS `palm_information_type`; 
CREATE TABLE `palm_information_type`(  
  `id` INT(11) NOT NULL  COMMENT 'id',
  `type` INT(11) COMMENT '发送类型 1 只发送短信 2 只推送 3 即发送信息也推送 4 即不发送信息也不推送',
  `name` varchar(32) COMMENT '名称：校园公告，在线请假，会议通知，宿舍通知，校车通知, 短信平台，成绩通知, 进出校园,一卡通，一体机、晨检 , 作息时间设置',
  `parentId` INT(11) COMMENT '父ID 如 一卡通的id为9 又分为消费 充值等,那消费对应的parentId为9， 如果没有就为空',
  `informationType` INT(11) COMMENT '信息类型 1校园公告，2在线请假，3会议通知，4宿舍通知，5校车通知, 6短信平台，7成绩通知, 8进出校园,9一卡通， 10 一体机， 11 晨检 , 12 作息时间设置',
  PRIMARY KEY (`id`),
  UNIQUE KEY `informationType` (`informationType`)
) ENGINE=INNODB CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='信息类型选择表 发送短信 推送'; 

INSERT INTO `palm_information_type` VALUES (1,null,'校园公告',null,1);
INSERT INTO `palm_information_type` VALUES (2,2,'学校公告通知',1,1001);
INSERT INTO `palm_information_type` VALUES (3,2,'部门公告通知',1,1002);
INSERT INTO `palm_information_type` VALUES (4,2,'班级公告通知',1,1003);
INSERT INTO `palm_information_type` VALUES (5,2,'系统公告通知',1,1004);
INSERT INTO `palm_information_type` VALUES (6,null,'在线请假',null,2);
INSERT INTO `palm_information_type` VALUES (7,3,'请假审批通知',6,2001);
INSERT INTO `palm_information_type` VALUES (8,3,'请假审批通过通知',6,2002);
INSERT INTO `palm_information_type` VALUES (9,3,'请假审批拒绝通知',6,2003);
INSERT INTO `palm_information_type` VALUES (10,3,'会议通知',NULL,3);
INSERT INTO `palm_information_type` VALUES (11,NULL,'宿舍通知',NULL,4);
INSERT INTO `palm_information_type` VALUES (12,2,'进宿舍通知',11,4001);
INSERT INTO `palm_information_type` VALUES (13,2,'出宿舍通知',11,4002);
INSERT INTO `palm_information_type` VALUES (14,NULL,'校车通知',NULL,5);
INSERT INTO `palm_information_type` VALUES (15,3,'上车通知',14,5001);
INSERT INTO `palm_information_type` VALUES (16,3,'下车通知',14,5002);
INSERT INTO `palm_information_type` VALUES (17,3,'成绩通知',NULL,7);
INSERT INTO `palm_information_type` VALUES (18,NULL,'进出校园',NULL,8);
INSERT INTO `palm_information_type` VALUES (19,3,'进学校通知',18,8001);
INSERT INTO `palm_information_type` VALUES (20,2,'出学校通知',18,8002);
INSERT INTO `palm_information_type` VALUES (21,2,'迟到',18,8003);
INSERT INTO `palm_information_type` VALUES (22,2,'早退',18,8004);
INSERT INTO `palm_information_type` VALUES (23,NULL,'一卡通',NULL,9);
INSERT INTO `palm_information_type` VALUES (24,3,'余额不足',23,9001);
INSERT INTO `palm_information_type` VALUES (25,2,'消费通知',23,9002);
INSERT INTO `palm_information_type` VALUES (26,3,'充值(存款)通知',23,9003);
INSERT INTO `palm_information_type` VALUES (27,2,'一体机',NULL,10);
INSERT INTO `palm_information_type` VALUES (28,NULL,'晨检',NULL,11);
INSERT INTO `palm_information_type` VALUES (29,3,'晨检结果正常',28,1101);
INSERT INTO `palm_information_type` VALUES (30,3,'晨检结果异常',28,1102);

DROP TABLE IF EXISTS `palm_inout`;
CREATE TABLE `palm_inout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '打卡的状态：1 进校 2出校',
  `position` int(11) DEFAULT NULL COMMENT '对应palm_device主键',
  `userId` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `sync` tinyint(3) DEFAULT NULL COMMENT '是否同步成功 1成功，0失败',
  `imgPath` varchar(255) DEFAULT NULL COMMENT '拍照图片路径 用于幼儿园一体机',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='进出校门刷卡记录表记录所有校门刷卡记录，数据来源于刷卡 ';
ALTER TABLE `palm_inout` ADD INDEX `PK_USERID` (`userId`) ;

DROP TABLE IF EXISTS `palm_inout_error`;
CREATE TABLE `palm_inout_error` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '打卡的状态：1 进校 2出校',
  `position` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `sync` tinyint(3) DEFAULT NULL COMMENT '是否同步成功 1成功，0失败',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='进出校门错误表';

DROP TABLE IF EXISTS `palm_inout_abnormal`;
CREATE TABLE `palm_inout_abnormal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '类型 1进校  2出校',
  `message` varchar(256) DEFAULT NULL,
  `sentTime` datetime DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='进出异常表用于统计进出校异常 ：在上课时间段内多次进出校园，或者住校人员出校';

DROP TABLE IF EXISTS `palm_inout_abnormal_detail`;
CREATE TABLE `palm_inout_abnormal_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `time` varchar(300) DEFAULT NULL,
  `gradeId` int(11) DEFAULT NULL,
  `clazzId` int(11) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `positionId` int(11) DEFAULT NULL,
  `positionTime` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='进出异常详情表';

DROP TABLE IF EXISTS `palm_patrol`;
CREATE TABLE `palm_patrol` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userId` INT(11) DEFAULT NULL COMMENT '用户id',
  `code` VARCHAR(20) DEFAULT NULL COMMENT '用户工号',
  `realName` VARCHAR(12) DEFAULT NULL COMMENT '用户姓名',
  `phone` VARCHAR(20) DEFAULT NULL COMMENT '用户手机号',
  `departmentId` INT(11) DEFAULT NULL COMMENT '用户所属部门Id',
  `departmentName` VARCHAR(10) DEFAULT NULL COMMENT '用户所属部门名称',
  `startDate` DATE DEFAULT NULL COMMENT '开始日期 YYYY-MM-DD',
  `startTime` DATETIME DEFAULT NULL COMMENT '开始时间 YYYY-MM-DD HH:mm:ss',
  `endDate` DATE DEFAULT NULL COMMENT '结束日期 YYYY-MM-DD',
  `endTime` DATETIME DEFAULT NULL COMMENT '结束时间 YYYY-MM-DD HH:mm:ss',
  `placeId` INT(11) DEFAULT NULL COMMENT '地点ID',
  `createTime` DATETIME DEFAULT NULL COMMENT '创建时间',
  `updateTime` DATETIME DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COMMENT '校务巡查巡更设置表';

DROP TABLE IF EXISTS `palm_patrol_place`;
CREATE TABLE `palm_patrol_place` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(32) DEFAULT NULL COMMENT '巡更点编号',  
  `name` VARCHAR(32) DEFAULT NULL COMMENT '巡更点名称',
  `position` VARCHAR(32) DEFAULT NULL COMMENT '巡更点纬度，经度',
  `createTime` DATETIME DEFAULT NULL,
  `updateTime` DATETIME DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='巡更地点';

DROP TABLE IF EXISTS `palm_patrol_inout`;
CREATE TABLE `palm_patrol_inout` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userId` varchar(12) DEFAULT NULL COMMENT '用户id',
  `status` varchar(20) DEFAULT NULL COMMENT '巡更状态的状态：0:范围内  1:范围外',
  `placeId` int(11) DEFAULT NULL COMMENT '巡更地点ID',
  `placeName` varchar(32) DEFAULT NULL COMMENT '实际输入的巡更点名称',
  `position` varchar(32) DEFAULT NULL COMMENT '实际巡更位置',
  `inoutDate` date DEFAULT NULL COMMENT '刷卡日期',
  `inoutTime` datetime DEFAULT NULL COMMENT '刷卡时间',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COMMENT='校务巡查巡更刷卡记录表';

DROP TABLE IF EXISTS `palm_leave`;
CREATE TABLE `palm_leave` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `startTime` varchar(50) DEFAULT NULL,
  `endTime` varchar(50) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '0事假1病假2产假3出差',
  `remark` varchar(255) DEFAULT NULL COMMENT '说明请假理由',
  `auditId` int(11) DEFAULT NULL COMMENT '审核人ID',
  `applyUserId` int(11) DEFAULT NULL COMMENT '请假者ID',
  `auditStatus` varchar(45) DEFAULT '0' COMMENT '审核状态  0 未审核 1审核通过 2 审核不通过',
  `auditTime` datetime DEFAULT NULL COMMENT '审核时间',
  `auditRemark` varchar(255) DEFAULT NULL COMMENT '审核备注',
  `createTime` datetime DEFAULT NULL COMMENT '生成时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='请假申请表,用于老师在线请假申请记录';

DROP TABLE IF EXISTS `palm_meeting`;
CREATE TABLE `palm_meeting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `startTime` varchar(50) DEFAULT NULL,
  `endTime` varchar(50) DEFAULT NULL,
  `place` int(11) DEFAULT NULL,
  `content` varchar(5000) DEFAULT NULL,
  `person` varchar(1000) DEFAULT NULL COMMENT '存储的是一个list',
  `remark` varchar(1000) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `userId` int(11) DEFAULT NULL COMMENT '添加会议人的ID',
  `inoutType` int(1) not null DEFAULT 0 COMMENT '会议签到方式0:刷卡 1:wifi签到',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='存储添加的会议';

DROP TABLE IF EXISTS `palm_meeting_detail`;
CREATE TABLE `palm_meeting_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `meetingName` varchar(200) DEFAULT NULL,
  `content` varchar(100) DEFAULT NULL,
  `attendeeId` int(11) DEFAULT NULL COMMENT '参会人ID',
  `attendee` varchar(100) DEFAULT NULL,
  `attenStatus` int(11) DEFAULT NULL COMMENT '0:正常出勤 1:迟到 2.早退 3.缺勤',
  `meetingTime` varchar(100) DEFAULT NULL COMMENT '会议的开始时间+结束时间',
  `meetingPlace` int(11) DEFAULT NULL,
  `meetingId` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='主要是将会议表下的人员拆分 ';

DROP TABLE IF EXISTS `palm_meeting_inout`;
CREATE TABLE `palm_meeting_inout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '0:正常出勤 1:迟到 2.早退 3.缺勤',
  `position` int(11) DEFAULT NULL COMMENT '对应palm_device主键',
  `userId` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `sync` tinyint(3) DEFAULT NULL,
  `meetingId` int(11) DEFAULT NULL COMMENT '会议Id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='存储会议打卡信息记录表';

DROP TABLE IF EXISTS `palm_meeting_inout_wifi`;
CREATE TABLE `palm_meeting_inout_wifi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) DEFAULT 0 COMMENT '0:正常出勤 1:迟到 2.早退 3.缺勤',
  `position` varchar(20)  CHARACTER SET utf8mb4 COMMENT '定位信息;纬度,经度',
  `wifi` varchar(20) character set utf8mb4 COMMENT 'wifi信息',
  `device` varchar(20)  CHARACTER SET utf8mb4 COMMENT '设备信息',
  `userId` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `meetingId` int(11) DEFAULT NULL COMMENT '会议Id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='存储会议手机签到信息记录表';

DROP TABLE IF EXISTS `palm_menu`;
CREATE TABLE `palm_menu` (
  `id` varchar(50) NOT NULL COMMENT '菜单编码',
  `name` varchar(20) NOT NULL COMMENT '菜单名称',
  `status` char(1) NOT NULL DEFAULT '0' COMMENT '是否启用:0 启用 1：禁用',
  `parentId` varchar(50) DEFAULT NULL COMMENT '父菜单ID',
  `url` varchar(200) DEFAULT NULL COMMENT '页面链接',
  `icon` varchar(50) DEFAULT NULL COMMENT '图标',
  `isSystem` char(1) DEFAULT '1' COMMENT '是否系统设定：0 是 不允许修改 1 否 允许客户设置',
  `permissionCode` varchar(32) DEFAULT NULL COMMENT '权限编码',
  `orders` int(3) DEFAULT NULL COMMENT '排序号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='菜单表';

INSERT INTO `palm_menu` VALUES ('safeSchool', '平安校园', '0', null, null, 'fa-shield', '1', null, '1');
INSERT INTO `palm_menu` VALUES ('inout', '进出记录', '0', 'safeSchool', 'inout/toInoutList.do', 'fa-file-text-o', '1', 'inoutManager', '1');
INSERT INTO `palm_menu` VALUES ('abnormal', '异常信息', '0', 'safeSchool', 'abnormal/toAbnormalList.do', 'fa-info-circle', '1', 'abnormal', '2');
INSERT INTO `palm_menu` VALUES ('sysMessage', '系统消息', '0', 'safeSchool', 'sysMessage/toSysMessageList.do', 'fa-envelope-o', '1', 'sysMessage', '3');
INSERT INTO `palm_menu` VALUES ('accessInoutAbnormal', '无障碍异常记录', '1', 'safeSchool', 'accessInout/toAccessInoutAbnormal.do', 'fa-envelope-o', '1', 'accessInoutAbnormal', '4');
INSERT INTO `palm_menu` values ('patrol','校务巡更','1','safeSchool','patrol/toPatrolList.do','fa fa-retweet','1','patrol','6');
INSERT INTO `palm_menu` VALUES ('schoolManager', '校园管理', '0', null, null, 'fa-th-large', '1', null, '2');
INSERT INTO `palm_menu` VALUES ('departManage', '部门管理', '0', 'schoolManager', 'depart/toDepartList.do', 'fa-th-large', '1', 'departManager', '1');
INSERT INTO `palm_menu` VALUES ('gradeManage', '年级管理', '0', 'schoolManager', 'grade/toGradeList.do', 'fa-th', '1', 'gradeManager', '2');
INSERT INTO `palm_menu` VALUES ('clazzManage', '班级管理', '0', 'schoolManager', 'clazz/toClazzList.do', 'fa-reorder', '1', 'classManager', '3');
INSERT INTO `palm_menu` VALUES ('teacherManage', '教职工管理', '0', 'schoolManager', 'teacher/toTeacherList.do', 'fa-group', '1', 'teacherManager', '4');
INSERT INTO `palm_menu` VALUES ('studentParentManage', '学生家长管理', '0', 'schoolManager', 'student/toStudentList.do', 'fa-user', '1', 'studentParentManager', '5');
INSERT INTO `palm_menu` VALUES ('cardManage', '电子卡管理', '0', 'schoolManager', 'card/toCardList.do', 'fa-credit-card', '1', 'cardManager', '6');
INSERT INTO `palm_menu` VALUES ('scheduleManage', '设定作息时间', '0', 'schoolManager', 'schedule/toScheduleList.do', 'fa-clock-o', '1', 'restTimeManager', '7');
INSERT INTO `palm_menu` VALUES ('placeManage', '设备位置管理', '0', 'schoolManager', 'place/toPlaceList.do', 'fa-map-marker', '1', 'positionManager', '8');
INSERT INTO `palm_menu` VALUES ('schoolInfoManage', '校园基本资料', '0', 'schoolManager', 'school/toSchoolInfoConfig.do', 'fa-list-ul', '1', 'schoolInfoManage', '9');
INSERT INTO `palm_menu` VALUES ('schoolNewsManage', '校园新闻发布', '0', 'schoolManager', 'schoolNews/toAddSchoolNews.do', 'fa-newspaper-o', '1', 'schoolNewsManage', '10');
INSERT INTO `palm_menu` VALUES ('informationPlatform', '信息中心', '0', null, null, 'fa-comments', '1', null, '3');
INSERT INTO `palm_menu` VALUES ('announcementShow', '公告通知', '0', 'informationPlatform', 'announcement/toAnnouncementList.do', 'fa-inbox', '1', 'announcementManager', '1');
INSERT INTO `palm_menu` VALUES ('teacherSms', '教师短信服务', '0', 'informationPlatform', 'sms/toTeacherSms.do', 'fa-envelope', '1', 'teacherMessageManager', '2');
INSERT INTO `palm_menu` VALUES ('studentSms', '学生短信服务', '0', 'informationPlatform', 'sms/toStudentSms.do', 'fa-envelope-o', '1', 'studentMessageManager', '3');
INSERT INTO `palm_menu` VALUES ('scoreSending', '作业成绩下发', '1', 'informationPlatform', 'sms/toScoreSending.do', 'fa-download', '1', 'sendScoreManager', '4');
INSERT INTO `palm_menu` VALUES ('mySms', '我的信息', '0', 'informationPlatform', 'sms/toMySms.do', 'fa-user', '1', 'myMessageManager', '5');
INSERT INTO `palm_menu` VALUES ('smsShow', '发送短信查看', '0', 'informationPlatform', 'sms/toSmsList.do', 'fa-envelope-square', '1', 'sendMessageHistoryManager', '6');
INSERT INTO `palm_menu` VALUES ('onlineTeacherMessage', '教师在线留言', '0', 'informationPlatform', 'online-message/toTeacherSms.do', 'fa-comment', '1', 'teacherOnlineMessageManager', '7');
INSERT INTO `palm_menu` VALUES ('onlineStudentMessage', '学生在线留言', '0', 'informationPlatform', 'online-message/toStudentSms.do', 'fa-comment-o', '1', 'studentOnlineMessageManager', '8');
INSERT INTO `palm_menu` VALUES ('onlineMessageShow', '发送留言查看', '0', 'informationPlatform', 'online-message/toSmsList.do', 'fa-commenting-o', '1', 'sendOnlineMessageHistoryManager', '9');
INSERT INTO `palm_menu` VALUES ('leave', '在线请假', '0', null, null, 'fa-calendar-minus-o', '1', null, '4');
INSERT INTO `palm_menu` VALUES ('applyLeave', '请假申请', '0', 'leave', 'leave/toLeaveList.do', 'fa-calendar-plus-o', '1', 'leaveApplyManager', '1');
INSERT INTO `palm_menu` VALUES ('auditLeave', '请假审核', '0', 'leave', 'leave/toLeaveAudit.do', 'fa-calendar-check-o', '1', 'leaveAuditManager', '2');
INSERT INTO `palm_menu` VALUES ('attendance', '师生考勤', '0', null, null, 'fa-clipboard', '1', null, '5');
INSERT INTO `palm_menu` VALUES ('teacherAttend', '老师考勤', '0', 'attendance', 'check/toTeacherCheckList.do', 'fa-align-left', '1', 'teacherAttendanceManager', '1');
INSERT INTO `palm_menu` VALUES ('studentAttend', '学生考勤', '0', 'attendance', 'check/toStudentCheckList.do', 'fa-dedent', '1', 'studentAttendanceManager', '2');
INSERT INTO `palm_menu` VALUES ('attendanceReport', '考勤统计', '0', 'attendance', 'check/toCheckReport.do', 'fa-file-text', '1', 'attendanceStatisticsManager', '3');
INSERT INTO `palm_menu` VALUES ('attendanceFill', '考勤补录', '0', 'attendance', 'check/toAttendanceRecord.do', 'fa-paint-brush', '1', 'attendanceRecordManager', '4');
INSERT INTO `palm_menu` VALUES ('meetingManager', '会议管理', '0', null, null, 'fa-users', '1', null, '6');
INSERT INTO `palm_menu` VALUES ('meetPlan', '会议安排', '0', 'meetingManager', 'meeting/toMeetingList.do', 'fa-pencil-square', '1', 'meetingArrangementManager', '1');
INSERT INTO `palm_menu` VALUES ('meetingInout', '会议签到', '0', 'meetingManager', 'meetingInout/toMeetingInout.do', 'fa-file-text-o', '1', 'meetingInoutManager', '2');
INSERT INTO `palm_menu` VALUES ('meetingDetail', '会议记录', '0', 'meetingManager', 'meetingDetail/toMeetingDetailList.do', 'fa-list-alt', '1', 'meetingRecordManager', '3');
INSERT INTO `palm_menu` VALUES ('dormitoryManage', '宿舍管理', '1', null, null, 'fa-building-o', '1', 'dormitoryManager', '7');
INSERT INTO `palm_menu` VALUES ('dormitoryInout', '进出宿舍', '1', 'dormitoryManage', 'dormitory/toDormitoryInoutList.do', 'fa-navicon', '1', 'dormitoryInoutManager', '1');
INSERT INTO `palm_menu` VALUES ('dormitoryAbnormal', '宿管异常', '1', 'dormitoryManage', 'dormitory/toDormitoryAbnormalDetailList.do', 'fa-exclamation-circle', '1', 'dormitoryAbnormalManager', '2');
INSERT INTO `palm_menu` VALUES ('schoolBusManage', '校车管理', '1', null, null, 'fa-bus', '1', null, '8');
INSERT INTO `palm_menu` VALUES ('schoolBusDetail', '校车记录', '1', 'schoolBusManage', 'schoolbus/toSchoolBusOnList.do', 'fa-file-text-o', '1', 'schoolBusOnManager', '1');
INSERT INTO `palm_menu` VALUES ('schoolBusSchedule', '校车时间设定', '1', 'schoolBusManage', 'schoolbusSchedule/toSchoolBusScheduleList.do', 'fa-clock-o', '1', 'schoolBusScheduleManager', '2');
INSERT INTO `palm_menu` VALUES ('schoolBusReport', '校车报表', '1', 'schoolBusManage', 'schoolbus/toSchoolBusReport.do', 'fa-print', '1', 'schoolBusReportManager', '3');
INSERT INTO `palm_menu` VALUES ('schoolBusSms', '校车短信记录', '1', 'schoolBusManage', 'schoolbusSms/toSchoolBusSms.do', 'fa-file-o', '1', 'schoolBusSmsManager', '4');
INSERT INTO `palm_menu` VALUES ('schoolBusNowPosition', '校车当前位置', '1', 'schoolBusManage', 'schoolbus/toSchoolBusNowPoint.do', 'fa-print', '1', 'schoolBusNowPositionManager', '5');
INSERT INTO `palm_menu` VALUES ('xyYktManager', '校园一卡通', '1', null, null, 'fa-credit-card', '1', null, '9');
INSERT INTO `palm_menu` VALUES ('yktTotalManager', '总览', '1', 'xyYktManager', 'ykt/toYktTotalList.do', 'fa-sticky-note', '1', 'yktTotalManager', '1');
INSERT INTO `palm_menu` VALUES ('clazzPhotoAlbumManager', '校园相册', '0', null, null, 'fa-calendar', '1', null, '10');
INSERT INTO `palm_menu` VALUES ('clazzPhotoAlbum', '班级相册', '0', 'clazzPhotoAlbumManager', 'clazzAlbum/toClazzPhotoAlbumList.do', 'fa fa-file-image-o', '1', null, '1');
INSERT INTO `palm_menu` VALUES ('selfPhotoAlbum', '个人相册', '0', 'clazzPhotoAlbumManager', 'personAlbum/toPersonAlbum.do', 'fa fa-file-powerpoint-o', '1', NULL, '2');
INSERT INTO `palm_menu` VALUES ('evaluationManager', '教学评价', '0', null, null, 'fa-star-half-full', '1', null, '11');
INSERT INTO `palm_menu` VALUES ('setEvaluationTimeManager', '时间设定', '0', 'evaluationManager', 'evaluation/toEvaluationTime.do', 'fa-clock-o', '1', 'setEvaluationTimeManager', '1');
INSERT INTO `palm_menu` VALUES ('setEvaluationTemplateManager', '模板设定', '0', 'evaluationManager', 'evaluation/toEvaluationTemplate.do', 'fa-tasks', '1', 'setEvaluationTemplateManager', '2');
INSERT INTO `palm_menu` VALUES ('evaluationListManager', '评价列表', '0', 'evaluationManager', 'evaluation/toEvaluationList.do', 'fa-list-ul', '1', 'evaluationListManager', '3');
INSERT INTO `palm_menu` VALUES ('teacherEvaluationViewManager', '教师评价查看', '0', 'evaluationManager', 'evaluation/toTeacherEvaluationView.do', 'fa-file-text-o', '1', 'teacherEvaluationViewManager', '4');
INSERT INTO `palm_menu` VALUES ('studentEvaluationViewManager', '学生评价查看', '0', 'evaluationManager', 'evaluation/toStudentEvaluationView.do', 'fa-file', '1', 'studentEvaluationViewManager', '5');
INSERT INTO `palm_menu` VALUES ('teacherEvaluationDetailManager', '已评或未评教师', '0', 'evaluationManager', 'evaluation/toTeacherEvaluationDetail.do', 'fa-user', '1', 'teacherEvaluationDetailManager', '6');
INSERT INTO `palm_menu` VALUES ('studentEvaluationDetailManager', '已评或未评学生', '0', 'evaluationManager', 'evaluation/toStudentEvaluationDetail.do', 'fa-male', '1', 'studentEvaluationDetailManager', '7');
INSERT INTO `palm_menu` VALUES ('curriculum', '电子课程表', '1', null, null, 'fa-calendar', '1', null, '12');
INSERT INTO `palm_menu` VALUES ('curriculumManager', '电子课程表', '1', 'curriculum', 'curriculum/toSetCurriculum.do', 'fa-calendar', '1', 'curriculumManager', '1');
INSERT INTO `palm_menu` VALUES ('cloudAchievement', '系统云成绩查看', '1', null, null, 'fa-file-text', '1', null, '13');
INSERT INTO `palm_menu` VALUES ('scoreShow', '作业成绩查看', '1', 'cloudAchievement', 'score/toScoreList.do', 'fa-file-text', '1', 'scoreShow', '1');
INSERT INTO `palm_menu` VALUES ('campusNewsManager','校园新闻','1',NULL,NULL,'fa-list-alt','1','campusNewsManager','14');
INSERT INTO `palm_menu` VALUES ('schoolNewsRelease','校园新闻发布','1','campusNewsManager','schoolNewsRelease/toSchoolNewsRelease.do','fa-file-word-o','1','schoolNewsReleaseManager','1');
INSERT INTO `palm_menu` VALUES ('schoolNewsLook','校园新闻查看','1','campusNewsManager','schoolNewsLook/toSchoolNewsLook.do','fa-eye','1','schoolNewsLookManager','2');
INSERT INTO `palm_menu` VALUES ('siguUpManager','信息发布管理','1',NULL,NULL,'fa-file-text','1','signUpManager','15');
INSERT INTO `palm_menu` VALUES ('signUpInfoManager','招生信息采集','1','siguUpManager','applyInfo/toApplyInfoList.do','fa-file-text','1','signUpInfoManager','1');
INSERT INTO `palm_menu` VALUES ('activityInformationManager','活动信息采集','1','siguUpManager','applyInfo/toActivityInfoList.do','fa-file-text','1','activityInformationManager','2');
INSERT INTO `palm_menu` VALUES ('liveCameraManager','视频直播','1',NULL,NULL,'fa fa-video-camera','1',NULL,'16');
INSERT INTO `palm_menu` VALUES ('liveCamera','视频直播','1','liveCameraManager','camera/toLiveCamera.do','icon-film','1',NULL,'1');
INSERT INTO `palm_menu` VALUES ('cameraManager','视频管理','1','liveCameraManager','camera/toCameraManager.do','fa-object-group','1',NULL,'2');
INSERT INTO `palm_menu` VALUES ('teachingResourcesManager','教学资源','1',NULL,NULL,'fa fa-book','1',NULL,'17');
INSERT INTO `palm_menu` VALUES ('teachingResources','教学资源','1','teachingResourcesManager','teachingResources/toTeachingResources.do','fa fa-book','1',NULL,'1');
INSERT INTO `palm_menu` VALUES ('messageManage','服务费订购','0',NULL,NULL,'fa fa-send','1','messageManage','18');
INSERT INTO `palm_menu` VALUES ('orderMessageManager', '服务费订购', '0', 'messageManage', 'orderMessage/toOrderMessage.do', 'fa fa-wechat', '1', 'orderMessageManager', '1');
INSERT INTO `palm_menu` VALUES ('replaceRecharge','服务费代充','0','messageManage','replaceRecharge/toReplaceRecharge.do','fa fa-send-o','1','replaceRechargeManager','2');
INSERT INTO `palm_menu` VALUES ('assetManagement','资产管理','0',NULL,NULL,'fa fa-cubes','1','assetManagementManager','19'); 
INSERT INTO `palm_menu` VALUES ('assetInfoList','资产信息','0','assetManagement','asset/toAssetInfoList.do','fa fa-building-o','1','assetInfoListManager','1');  
INSERT INTO `palm_menu` VALUES ('assetRepair','资产报修','0','assetManagement','asset/toAssetRepair.do','fa fa-wrench','1','assetRepairManager','2');  
INSERT INTO `palm_menu` VALUES ('assetServicemanList','维修人员列表','0','assetManagement','asset/toAssetServicemanList.do','fa fa-user-plus','1','assetServicemanManager','3');  
INSERT INTO `palm_menu` VALUES ('assetRepairList','维修列表','0','assetManagement','asset/toAssetRepairList.do','fa fa-tasks','1','assetRepairListManager','4');  
INSERT INTO `palm_menu` VALUES ('securityDanger', '安全隐患排查', '0', 'assetManagement', 'securityDanger/toSecurityDanger.do', 'fa fa-building-o', '1', 'securityDanger', '5');
INSERT INTO `palm_menu` VALUES ('systemManage', '系统管理', '0', null, null, 'fa-gears', '1', null, '20');
INSERT INTO `palm_menu` VALUES ('becomeUser', '切换用户', '0', 'systemManage', 'user/toBecomeUser.do', 'fa-exchange', '1', 'becomeUser', '1');
INSERT INTO `palm_menu` VALUES ('permissionManage', '权限管理', '0', 'systemManage', 'permission/toSetPermission.do', 'fa-briefcase', '1', 'permissionManage', '2');
INSERT INTO `palm_menu` VALUES ('informationType', '推送信息设置', '1', 'systemManage', 'informationType/toSetInformationType.do', 'fa-edit', '1', 'informationTypeManager', '3');
INSERT INTO `palm_menu` VALUES ('deviceMonitor', '设备监控', '0', 'systemManage', 'deviceMonitor/toDeviceMonitor.do', 'fa-exclamation-triangle', '1', 'deviceManager', '4');
INSERT INTO `palm_menu` VALUES ('addCardApply', '补办卡申请', '0', 'systemManage', 'cardApply/toAddCardApply.do', 'fa-edit', '1', 'addCardApply', '6');
INSERT INTO `palm_menu` VALUES ('changePassword', '修改密码', '0', 'systemManage', 'user/toModifyPassword.do', 'fa-unlock-alt', '1', null, '7');
INSERT INTO `palm_menu` VALUES ('menuConfig', '菜单管理', '1', 'systemManage', 'menu/toMenuConfig.do', 'fa-sticky-note', '1', 'menuConfig', '8');
INSERT INTO `palm_menu` VALUES ('dynamicGraph','动态图录入','1','systemManage','dynamicGraph/toDynamicGraph.do','fa-opencart','1','dynamicGraphManager','9');
INSERT INTO `palm_menu` VALUES ('setAPPHomePage','APP首页设置','1','systemManage','appHomePage/toSetAppHomePage.do','fa-houzz','1','setAPPHomePageManager','10');
INSERT INTO `palm_menu` VALUES ('serviceFee','服务费设置','1','systemManage','replaceRecharge/toServiceFeeList.do','fa-ils','1','serviceFeeManager','11');
INSERT INTO `palm_menu` VALUES ('applyCash','提现管理','1','systemManage','wallet/toApplyCashList.do','fa-yen','1','applyCashManager','12');

DROP TABLE IF EXISTS `palm_morningcheck`;
CREATE TABLE `palm_morningcheck` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL COMMENT '用户ID',
  `temperature` varchar(10) DEFAULT NULL COMMENT '体温',
  `spirit` varchar(100) DEFAULT NULL COMMENT '精神状况',
  `oralCavity` varchar(100) DEFAULT NULL COMMENT '口腔状况',
  `surface` varchar(100) DEFAULT NULL COMMENT '形象',
  `teacherId` int(11) DEFAULT NULL COMMENT '检测老师ID',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `state` int DEFAULT 0 COMMENT '状态 0：正常 1：异常',
  `cardCode` varchar(20) DEFAULT null COMMENT '卡号',
  `teacherCardCode` varchar(20) DEFAULT null COMMENT '晨检老师卡号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `palm_news`;
CREATE TABLE `palm_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL COMMENT '标题',
  `content` text COMMENT '内容',
  `imgPath` varchar(150) DEFAULT NULL COMMENT '图片地址',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `status` char(1) DEFAULT '0' COMMENT '状态 0 使用 1禁用',
  `createUserId` int(11) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='学校新闻';

DROP TABLE IF EXISTS `palm_online_message`;
CREATE TABLE `palm_online_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `content` varchar(256) NOT NULL COMMENT '留言内容',
  `senderId` int(11) NOT NULL COMMENT '发送者ID',
  `module` int(11) NOT NULL COMMENT '1:教师 2:学生',
  `sentTime` varchar(100) DEFAULT NULL COMMENT '发送时间',
  `createTime` varchar(100) NOT NULL COMMENT '创建时间',
  `senderName` varchar(20) DEFAULT NULL COMMENT '发送人姓名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='在线留言表';

DROP TABLE IF EXISTS `palm_online_message_detail`;
CREATE TABLE `palm_online_message_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(768) NOT NULL COMMENT '留言内容',
  `senderId` int(11) NOT NULL COMMENT '发送人id',
  `senderName` varchar(96) DEFAULT NULL COMMENT '发送者姓名',
  `receiverId` int(11) NOT NULL COMMENT '接受人id',
  `receiverName` varchar(96) DEFAULT NULL COMMENT '接受人姓名',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '已读（0）/未读（1）',
  `onlineMessageid` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `sentTime` datetime DEFAULT NULL COMMENT '发送时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='在线留言详情';

DROP TABLE IF EXISTS `palm_order_message`;
CREATE TABLE `palm_order_message` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` VARCHAR(32) DEFAULT NULL COMMENT '商品名',
  `price` DOUBLE DEFAULT NULL COMMENT '价格',
  `startTime` DATE DEFAULT NULL COMMENT '生效开始时间',
  `endTime` DATE DEFAULT NULL COMMENT '生效结束时间',
  `type` INT(1) DEFAULT NULL COMMENT '0包时间段 1 单价/每条',
  `status` INT(1) DEFAULT NULL COMMENT '0可用 1失效',
  `createTime` VARCHAR(32) DEFAULT NULL COMMENT '创建时间',
  `updateTime` VARCHAR(32) DEFAULT NULL COMMENT '更新时间',
  `isVirtual` VARCHAR(1) DEFAULT '1' COMMENT '是否是虚拟套餐0:是 1:否',
  `rangeObject` INT(1) DEFAULT '1' COMMENT '套餐范围0:学校,1:个人',
  `cardPrice` double DEFAULT '0' COMMENT '卡押金',
  `servicePrice` double DEFAULT '0' COMMENT '服务费',
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='短信套餐表';
INSERT  INTO `palm_order_message`(`name`,`price`,`startTime`,`endTime`,`type`,`status`,`createTime`,`updateTime`,`isVirtual`,`rangeObject`) VALUES ('虚拟套餐',0.00,NOW(),NOW(),0,0,NOW(),NOW(),'0','0');

DROP TABLE IF EXISTS `palm_order_message_school`;
CREATE TABLE `palm_order_message_school` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` VARCHAR(32) DEFAULT NULL COMMENT '商品名',
  `schoolId` VARCHAR(32) DEFAULT NULL COMMENT '学校Id',
  `userId` INT(11) DEFAULT NULL COMMENT '购买人Id',
  `startTime` DATE DEFAULT NULL COMMENT '生效开始时间',
  `endTime` DATE DEFAULT NULL COMMENT '生效结束时间',
  `type` INT(1) DEFAULT NULL COMMENT '0包时间段 1 单价/每条',
  `count` INT(11) DEFAULT NULL COMMENT '购买的条数',
  `remainCount` INT(11) DEFAULT NULL COMMENT '剩余条数',
  `createTime` VARCHAR(32) DEFAULT NULL COMMENT '创建时间',
  `updateTime` VARCHAR(32) DEFAULT NULL COMMENT '更新时间',
  `orderId` INT(11) DEFAULT NULL COMMENT '订单id',
  `status` INT(1) DEFAULT NULL COMMENT '状态 0可用 1不可用',
  `messageId` INT(11) DEFAULT NULL COMMENT '对应的套餐id',
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=333 DEFAULT CHARSET=utf8 COMMENT='学校套餐购买表';

DROP TABLE IF EXISTS `palm_order_message_user`;
CREATE TABLE `palm_order_message_user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` VARCHAR(32) DEFAULT NULL COMMENT '商品名',
  `realName` VARCHAR(32) DEFAULT NULL COMMENT '用户姓名',
  `userId` INT(11) DEFAULT NULL COMMENT '用户Id',
  `startTime` DATE DEFAULT NULL COMMENT '生效开始时间',
  `endTime` DATE DEFAULT NULL COMMENT '生效结束时间',
  `type` INT(1) DEFAULT NULL COMMENT '0包时间段 1 单价/每条',
  `count` INT(11) DEFAULT NULL COMMENT '购买的条数',
  `createTime` VARCHAR(32) DEFAULT NULL COMMENT '创建时间',
  `updateTime` VARCHAR(32) DEFAULT NULL COMMENT '更新时间',
  `orderId` INT(11) DEFAULT NULL COMMENT '订单id',
  `status` INT(1) DEFAULT NULL COMMENT '状态 0可用 1不可用',
  `messageId` INT(11) DEFAULT NULL COMMENT '对应的套餐id',
  `replaceUserId` INT(11) DEFAULT NULL COMMENT '代充人Id',
  `replaceRealName` VARCHAR(32) DEFAULT NULL COMMENT '代充值人姓名',
  `familyId` VARCHAR(32) DEFAULT NULL COMMENT '家庭id',
  `servicePrice` double DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COMMENT='短信套餐购买用户表';

DROP TABLE IF EXISTS `palm_order_message_user_detail`;
CREATE TABLE `palm_order_message_user_detail` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userId` INT(11) DEFAULT NULL COMMENT '用户id',
  `type` INT(1) DEFAULT NULL COMMENT '类型 0包时间段 1 单价/每条',
  `count` INT(11) DEFAULT NULL COMMENT '本次短信条数',
  `orgCount` INT(11) DEFAULT NULL COMMENT '原剩余条说',
  `nowCount` INT(11) DEFAULT NULL COMMENT '现剩余条数',
  `messageId` INT(11) DEFAULT NULL COMMENT '对应的套餐id',
  `messUserId` INT(11) DEFAULT NULL COMMENT '短信套餐用户购买Id',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `palm_order_message_clazz`;
CREATE TABLE `palm_order_message_clazz` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderMessageId` int(11) DEFAULT NULL COMMENT '套餐id',
  `clazzId` int(11) DEFAULT NULL COMMENT '对应的班级id',
  `createTime` varchar(32) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='短信套餐与年级的关系';

DROP TABLE IF EXISTS `palm_order_message_paymentnotice`;
CREATE TABLE `palm_order_message_paymentnotice` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `status` int(1) DEFAULT NULL COMMENT '0开启 1关闭',
  `createTime` varchar(32) DEFAULT NULL COMMENT '创建时间',
  `updateTime` varchar(32) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='学校服务费套餐催款通知';
INSERT INTO `palm_order_message_paymentnotice` VALUES (1,1, now(), now());

DROP TABLE IF EXISTS `palm_order_message_permission`;
CREATE TABLE `palm_order_message_permission` (
  `menuId` varchar(50) NOT NULL COMMENT '菜单Id',
  `menuName` varchar(50) DEFAULT NULL,
  `status` int(1) DEFAULT '0' COMMENT '未缴纳服务费是否限制功能使用 0不限制 1限制',
  PRIMARY KEY (`menuId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='未购买服务费对应的菜单限制表';

INSERT INTO `palm_order_message_permission` VALUES ('allWisdomFunction', '所有智慧校园功能', '0');
INSERT INTO `palm_order_message_permission` VALUES ('camera', '亦信摄像头', '0');

DROP TABLE IF EXISTS `palm_order_message_permission_detail`;
CREATE TABLE `palm_order_message_permission_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `menuId` varchar(50) DEFAULT NULL COMMENT 'palm_order_message_permisson的主键',
  `clazzId` int(11) DEFAULT NULL COMMENT '班级ID',
  `gradeId` int(11) DEFAULT NULL COMMENT '年级ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='未购买服务费对应的菜单限制详情表';

DROP TABLE IF EXISTS `palm_permission`;
CREATE TABLE `palm_permission` (
  `permissionCode` varchar(32) NOT NULL COMMENT '权限名称',
  `permissionName` varchar(500) NOT NULL COMMENT '权限描述',
  `type` char(1) NOT NULL DEFAULT '0' COMMENT '权限类型： 0 菜单权限  1按钮权限',
  `parentCode` varchar(32) DEFAULT NULL COMMENT '父页面菜单权限ID',
  PRIMARY KEY (`permissionCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='权限定义表';
INSERT INTO `palm_permission` VALUES ('abnormal', '异常信息', '0', null);
INSERT INTO `palm_permission` VALUES ('addCardApply', '补办卡申请', '0', null);
INSERT INTO `palm_permission` VALUES ('addCurriculum', '创建课程表', '1', 'curriculumManager');
INSERT INTO `palm_permission` VALUES ('addEvaluationTime', '添加评价时间', '1', 'setEvaluationTimeManager');
INSERT INTO `palm_permission` VALUES ('admin', '管理员', '0', null);
INSERT INTO `palm_permission` VALUES ('announcementAdd', '发布公告', '1', 'announcementManager');
INSERT INTO `palm_permission` VALUES ('announcementManager', '公告展示菜单', '0', null);
INSERT INTO `palm_permission` VALUES ('attendanceRecordManager', '考勤补录菜单', '0', null);
INSERT INTO `palm_permission` VALUES ('attendanceStatisticsManager', '考勤统计菜单', '0', null);
INSERT INTO `palm_permission` VALUES ('becomeUser', '切换用户', '0', null);
INSERT INTO `palm_permission` VALUES ('cardManager', '电子卡管理', '0', null);
INSERT INTO `palm_permission` VALUES ('classAdd', '增加班级', '1', 'classManager');
INSERT INTO `palm_permission` VALUES ('classDelete', '删除班级', '1', 'classManager');
INSERT INTO `palm_permission` VALUES ('classManager', '班级管理', '0', null);
INSERT INTO `palm_permission` VALUES ('classModify', '修改班级', '1', 'classManager');
INSERT INTO `palm_permission` VALUES ('clazzAnnouncementAdd', '班级公告发布', '1', 'announcementManager');
INSERT INTO `palm_permission` VALUES ('createClazzGroup', '创建班级群', '1', 'classManager');
INSERT INTO `palm_permission` VALUES ('createDepartGroup', '创建部门群', '1', 'departManager');
INSERT INTO `palm_permission` VALUES ('curriculumManager', '电子课程表', '0', null);
INSERT INTO `palm_permission` VALUES ('departAdd', '增加部门', '1', 'departManager');
INSERT INTO `palm_permission` VALUES ('departAddMember', '增加部门人员', '1', 'departManager');
INSERT INTO `palm_permission` VALUES ('departDelete', '删除部门', '1', 'departManager');
INSERT INTO `palm_permission` VALUES ('departDeleteMember', '删除部门人员', '1', 'departManager');
INSERT INTO `palm_permission` VALUES ('departManager', '部门管理', '0', null);
INSERT INTO `palm_permission` VALUES ('departmentAnnouncementAdd', '部门公告发布', '1', 'announcementManager');
INSERT INTO `palm_permission` VALUES ('departModify', '修改部门', '1', 'departManager');
INSERT INTO `palm_permission` VALUES ('deviceManager', '设备监控', '0', null);
INSERT INTO `palm_permission` VALUES ('dormitoryAbnormalManager', '宿管异常菜单', '0', null);
INSERT INTO `palm_permission` VALUES ('dormitoryInoutManager', '进出宿舍菜单', '0', null);
INSERT INTO `palm_permission` VALUES ('dormitoryManager', '宿舍管理菜单', '0', null);
INSERT INTO `palm_permission` VALUES ('editCurriculum', '编辑课程表', '1', 'curriculumManager');
INSERT INTO `palm_permission` VALUES ('evaluationListManager', '评价列表', '0', null);
INSERT INTO `palm_permission` VALUES ('gradeManager', '年级管理', '0', null);
INSERT INTO `palm_permission` VALUES ('importCurriculum', '导入课程表', '1', 'curriculumManager');
INSERT INTO `palm_permission` VALUES ('inoutManager', '进出记录菜单', '0', null);
INSERT INTO `palm_permission` VALUES ('leaveApplyManager', '请假申请菜单', '0', null);
INSERT INTO `palm_permission` VALUES ('leaveAuditForStudent', '学生请假申请审核人', '1', 'leaveAuditManager');
INSERT INTO `palm_permission` VALUES ('leaveAuditForTeacher', '老师请假申请审核人', '1', 'leaveAuditManager');
INSERT INTO `palm_permission` VALUES ('leaveAuditManager', '请假审核菜单', '0', null);
INSERT INTO `palm_permission` VALUES ('loadCurriculum', '下载课程表模板', '1', 'curriculumManager');
INSERT INTO `palm_permission` VALUES ('meetingArrangementManager', '会议安排菜单', '0', null);
INSERT INTO `palm_permission` VALUES ('meetingInoutManager', '会议刷卡记录菜单', '0', null);
INSERT INTO `palm_permission` VALUES ('meetingRecordManager', '会议记录菜单', '0', null);
INSERT INTO `palm_permission` VALUES ('modifyEvaluationTime', '修改评价时间', '1', 'setEvaluationTimeManager');
INSERT INTO `palm_permission` VALUES ('myMessageManager', '我的信息菜单', '0', null);
INSERT INTO `palm_permission` VALUES ('permissionManage', '权限管理', '0', null);
INSERT INTO `palm_permission` VALUES ('positionManager', '地点管理', '0', null);
INSERT INTO `palm_permission` VALUES ('restTimeAdd', '增加作息时间', '1', 'restTimeManager');
INSERT INTO `palm_permission` VALUES ('restTimeManager', '作息时间', '0', null);
INSERT INTO `palm_permission` VALUES ('restTimeModify', '修改作息时间', '1', 'restTimeManager');
INSERT INTO `palm_permission` VALUES ('saveCurriculum', '保存课程表', '1', 'curriculumManager');
INSERT INTO `palm_permission` VALUES ('schoolAnnouncementAdd', '学校公告发布', '1', 'announcementManager');
INSERT INTO `palm_permission` VALUES ('schoolBusOnManager', '校车记录菜单', '0', null);
INSERT INTO `palm_permission` VALUES ('schoolBusReportManager', '校车报表菜单', '0', null);
INSERT INTO `palm_permission` VALUES ('schoolBusSmsManager', '校车短信记录菜单', '0', null);
INSERT INTO `palm_permission` VALUES ('schoolInfoManage', '学校信息管理', '0', null);
INSERT INTO `palm_permission` VALUES ('schoolNewsManage', '学校新闻管理', '0', null);
INSERT INTO `palm_permission` VALUES ('sendMessageHistoryManager', '发送短信查看菜单', '0', null);
INSERT INTO `palm_permission` VALUES ('sendOnlineMessageHistoryManager', '发送留言查看菜单', '0', null);
INSERT INTO `palm_permission` VALUES ('sendScoreManager', '成绩下发菜单', '0', null);
INSERT INTO `palm_permission` VALUES ('setEvaluationTemplateManager', '评价模板设定', '0', null);
INSERT INTO `palm_permission` VALUES ('setEvaluationTimeManager', '评价时间设定', '0', null);
INSERT INTO `palm_permission` VALUES ('studentAttendanceManager', '学生考勤菜单', '0', null);
INSERT INTO `palm_permission` VALUES ('studentEvaluationDetailManager', '已评或未评学生', '0', null);
INSERT INTO `palm_permission` VALUES ('studentEvaluationViewManager', '学生评价查看', '0', null);
INSERT INTO `palm_permission` VALUES ('studentMessageManager', '学生短息服务菜单', '0', null);
INSERT INTO `palm_permission` VALUES ('studentOnlineMessageManager', '学生在线留言', '0', null);
INSERT INTO `palm_permission` VALUES ('studentParentAdd', '增加学生，家长', '1', 'studentParentManager');
INSERT INTO `palm_permission` VALUES ('studentParentDelete', '删除学生，家长', '1', 'studentParentManager');
INSERT INTO `palm_permission` VALUES ('studentParentManager', '学生家长管理', '0', null);
INSERT INTO `palm_permission` VALUES ('studentParentModify', '修改学生，家长', '1', 'studentParentManager');
INSERT INTO `palm_permission` VALUES ('sysMessage', '系统消息', '0', null);
INSERT INTO `palm_permission` VALUES ('systemAnnouncementAdd', '系统公告发布', '1', 'announcementManager');
INSERT INTO `palm_permission` VALUES ('teacherAdd', '增加教职工', '1', 'teacherManager');
INSERT INTO `palm_permission` VALUES ('teacherAttendanceManager', '教师考勤菜单', '0', null);
INSERT INTO `palm_permission` VALUES ('teacherDelete', '删除教职工', '1', 'teacherManager');
INSERT INTO `palm_permission` VALUES ('teacherEvaluationDetailManager', '已评或未评教师', '0', null);
INSERT INTO `palm_permission` VALUES ('teacherEvaluationViewManager', '教师评价查看', '0', null);
INSERT INTO `palm_permission` VALUES ('teacherManager', '教职工管理', '0', null);
INSERT INTO `palm_permission` VALUES ('teacherMessageManager', '教师短信服务菜单', '0', null);
INSERT INTO `palm_permission` VALUES ('teacherModify', '修改教职工', '1', 'teacherManager');
INSERT INTO `palm_permission` VALUES ('teacherOnlineMessageManager', '教师在线留言', '0', null);
INSERT INTO `palm_permission` VALUES ('yktTotalManager', '总览', '0', null);
INSERT INTO `palm_permission` VALUES ('schoolBusScheduleManager', '校车时间设置', '0', null);
INSERT INTO `palm_permission` VALUES ('informationTypeManager', '信息提醒类型', '0', null);
INSERT INTO `palm_permission` VALUES ('recipeListManager','菜谱管理菜单','0',NULL);
INSERT INTO `palm_permission` VALUES ('addRecipe','添加菜谱按钮','1','recipeListManager');
INSERT INTO `palm_permission` VALUES ('modifyRecipe','修改菜谱按钮','1','recipeListManager');
INSERT INTO `palm_permission` VALUES ('deleteRecipe','删除菜谱按钮','1','recipeListManager');
INSERT INTO `palm_permission` VALUES ('schoolBusNowPositionManager', '校车当前位置', '0', null);
INSERT INTO `palm_permission` VALUES ('menuConfig','菜单管理','1',null);
INSERT INTO `palm_permission` VALUES ('schoolNewsReleaseManager', '校园新闻发布', '0', NULL);
INSERT INTO `palm_permission` VALUES ('schoolNewsLookManager', '校园新闻查看', '0', NULL);
INSERT INTO `palm_permission` VALUES ('signUpInfoManager', '招生信息采集', '0', NULL);
INSERT INTO `palm_permission` VALUES ('cameraManager', '视频管理', '0', NULL);
INSERT INTO `palm_permission` VALUES ('cameraManagerEditor', '视频管理编辑', '1', 'cameraManager');
INSERT INTO `palm_permission` VALUES ('activityInformationManager', '活动信息采集', '0', NULL);
INSERT INTO `palm_permission` VALUES ('replaceRechargeManager', '服务费代充', '0', NULL);
INSERT INTO `palm_permission` VALUES ('messageManage', '智慧校园服务费', '0', NULL);
INSERT INTO `palm_permission` VALUES ('orderMessageManager', '服务费购买', '0', NULL);
INSERT INTO `palm_permission` VALUES ('schoolOrderMessage', '学校套餐设置和购买', '1', 'orderMessageManager');
INSERT INTO `palm_permission` VALUES ('accessInoutAbnormal', '无障碍异常记录', '0', NULL);
INSERT INTO `palm_permission` VALUES ('applyCashManager', '提现管理', '0', NULL);
INSERT INTO `palm_permission` VALUES ('patrol', '校务巡更', '0', NULL);
INSERT INTO `palm_permission` VALUES ('patrolModify', '校务巡更设置和修改', '1', 'patrol');
INSERT INTO `palm_permission` VALUES ('assetManagementManager', '资产管理', '0', NULL);
INSERT INTO `palm_permission` VALUES ('assetInfoListManager', '资产信息', '0', NULL);
INSERT INTO `palm_permission` VALUES ('assetImportManager', '资产导入', '1', 'assetInfoListManager');
INSERT INTO `palm_permission` VALUES ('assetAddManager', '资产添加', '1', 'assetInfoListManager');
INSERT INTO `palm_permission` VALUES ('assetDetailManager', '资产详情', '1', 'assetInfoListManager');
INSERT INTO `palm_permission` VALUES ('assetDeleteManager', '资产删除', '1', 'assetInfoListManager');
INSERT INTO `palm_permission` VALUES ('assetModifyManager', '资产修改', '1', 'assetInfoListManager');
INSERT INTO `palm_permission` VALUES ('assetRepairManager', '资产保修', '0', NULL);
INSERT INTO `palm_permission` VALUES ('assetRepairListManager', '维修列表', '0', NULL);
INSERT INTO `palm_permission` VALUES ('assetServicemanManager', '维修人员列表', '0', NULL);
INSERT INTO `palm_permission` VALUES ('assetServicemanAddManager', '添加维修人员', '1', 'assetServicemanManager');
INSERT INTO `palm_permission` VALUES ('assetServicemanDeleteManager', '删除维修人员', '1', 'assetServicemanManager');
INSERT INTO `palm_permission` VALUES ('securityDanger', '校园安全隐患排查', '0', 'assetManagementManager');
INSERT INTO `palm_permission` VALUES ('securityDangerAddMan', '添加排查人员', '1', 'securityDanger');
INSERT INTO `palm_permission` VALUES ('securityDangerDeleteMan', '删除排查人员', '1', 'securityDanger');

DROP TABLE IF EXISTS `palm_person_album`;
CREATE TABLE `palm_person_album` (
  `albumId` INT(11) NOT NULL AUTO_INCREMENT,
  `albumName` VARCHAR(32) DEFAULT NULL,
  `albumDesc` VARCHAR(255) DEFAULT NULL COMMENT '相册描述',
  `albumPath` VARCHAR(255) DEFAULT NULL COMMENT '相册封面路径',
  `userId` INT(11) DEFAULT NULL COMMENT '相册的归属人',
  `userName` VARCHAR(32) DEFAULT NULL,
  `createTime` VARCHAR(32) DEFAULT NULL,
  `updateTime` VARCHAR(32) DEFAULT NULL,
  PRIMARY KEY (`albumId`)
) ENGINE=INNODB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COMMENT='个人相册表';

DROP TABLE IF EXISTS `palm_person_photo`;
CREATE TABLE `palm_person_photo` (
  `photoId` int(11) NOT NULL AUTO_INCREMENT COMMENT '照片Id',
  `photoName` varchar(255) DEFAULT NULL COMMENT '照片名称',
  `photoDesc` varchar(255) DEFAULT NULL COMMENT '照片的描述',
  `photoPath` varchar(255) DEFAULT NULL COMMENT '照片地址',
  `albumId` int(11) DEFAULT NULL COMMENT '相册Id',
  `userId` int(11) DEFAULT NULL COMMENT '照片所归属人',
  `userName` varchar(32) DEFAULT NULL COMMENT '照片所归属人的姓名',
  `mediaType` int(1) DEFAULT NULL COMMENT '0文本，1图文，2音频，3视频，4签到，5链接 类型',
  `mediaSecordUrl` varchar(255) DEFAULT NULL COMMENT '当类型为3的时候封面url',
  PRIMARY KEY (`photoId`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8 COMMENT='存放个人照片表';


DROP TABLE IF EXISTS `palm_photo`;
CREATE TABLE `palm_photo` (
  `photoId` INT(11) NOT NULL AUTO_INCREMENT COMMENT '照片Id',
  `photoName` VARCHAR(255) DEFAULT NULL,
  `photoDesc` VARCHAR(255) DEFAULT NULL COMMENT '照片的描述',
  `photoPath` VARCHAR(255) DEFAULT NULL COMMENT '照片地址',
  `recordsId` INT(11) DEFAULT NULL COMMENT '记录Id',
  `albumId` INT(11) DEFAULT NULL COMMENT '相册Id',
  `createUserId` INT(11) DEFAULT NULL COMMENT '创建人Id',
  `createUserName` VARCHAR(32) DEFAULT NULL COMMENT '创建人姓名',
  `mediaType` INT(1) DEFAULT NULL COMMENT '0文本，1图文，2音频，3视频，4签到，5链接 类型',
  `mediaSecordUrl` VARCHAR(255) DEFAULT NULL COMMENT '当类型为3的时候封面url',
  PRIMARY KEY (`photoId`)
) ENGINE=INNODB AUTO_INCREMENT=173 DEFAULT CHARSET=utf8mb4 COMMENT='照片Id  一个图片对应一个相册 一条记录';

DROP TABLE IF EXISTS `palm_place`;
CREATE TABLE `palm_place` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '该地点的用途  1 校门 2宿舍 3会议室 4校车  等等',
  `functionId` int(11) DEFAULT NULL COMMENT '部门或者班级id',
  `functionType` int(11) DEFAULT NULL COMMENT '1表示functionId是班级Id 2表示functionId是部门Id',
  `createTime` datetime DEFAULT NULL,
  `wifi` varchar(32) COMMENT 'wifi名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='记录地点  每个地点下面可以有多个设备';

DROP TABLE IF EXISTS `palm_recipe`;
CREATE TABLE `palm_recipe` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `createTime` DATETIME DEFAULT NULL COMMENT '创建时间',
  `pushDate` VARCHAR(32) DEFAULT NULL COMMENT '发布日期(具体到日，也就是某天的菜单)',
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='食谱菜单';

DROP TABLE IF EXISTS `palm_records_comment`;
CREATE TABLE `palm_records_comment` (
  `commentId` INT(11) NOT NULL AUTO_INCREMENT COMMENT '评论Id',
  `parentId` INT(11) DEFAULT '0' COMMENT '父评论的id',
  `commentType` INT(11) DEFAULT NULL COMMENT '评论类型 0 点赞  1 文字回复',
  `content` VARCHAR(1000) DEFAULT NULL COMMENT '评论内容',
  `commentUserId` INT(11) DEFAULT NULL COMMENT '评论人Id',
  `commentUserName` VARCHAR(32) DEFAULT NULL COMMENT '评论姓名',
  `createTime` VARCHAR(32) DEFAULT NULL COMMENT '评论时间',
  `recordsId` INT(11) DEFAULT NULL COMMENT '上传记录id',
  `photoId` INT(11) DEFAULT '0' COMMENT '相册id',
  `commentReplyId` INT(11) DEFAULT '0' COMMENT '回复评论的id',
  `commentReplyUserId` INT(11) DEFAULT '0' COMMENT '回复评论的userId',
  `commentReplyUserName` VARCHAR(32) DEFAULT NULL COMMENT '回复评论的userName',
  PRIMARY KEY (`commentId`)
) ENGINE=INNODB AUTO_INCREMENT=796 DEFAULT CHARSET=utf8mb4 COMMENT='班级相册评表时对每一条记录的评论';

DROP TABLE IF EXISTS `palm_role`;
CREATE TABLE `palm_role` (
  `roleCode` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '角色名',
  `roleName` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '角色描述',
  PRIMARY KEY (`roleCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色定义表';

INSERT INTO `palm_role` VALUES ('admin', '学校管理员');
INSERT INTO `palm_role` VALUES ('chairman', '董事长');
INSERT INTO `palm_role` VALUES ('classLeader', '班主任');
INSERT INTO `palm_role` VALUES ('departManager', '部门管理员');
INSERT INTO `palm_role` VALUES ('employee', '职工');
INSERT INTO `palm_role` VALUES ('other', '其它');
INSERT INTO `palm_role` VALUES ('parent', '家长');
INSERT INTO `palm_role` VALUES ('president', '校(园)长');
INSERT INTO `palm_role` VALUES ('student', '学生');
INSERT INTO `palm_role` VALUES ('teacher', '教师');

DROP TABLE IF EXISTS `palm_role_permission`;
CREATE TABLE `palm_role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色权限表主键',
  `roleCode` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '角色表主键',
  `permissionCode` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '权限表主键',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色权限关系表';

INSERT INTO `palm_role_permission` VALUES ('1', 'admin', 'admin');
INSERT INTO `palm_role_permission` VALUES ('2', 'departManager', 'departManager');
INSERT INTO `palm_role_permission` VALUES ('3', 'departManager', 'departAddMember');
INSERT INTO `palm_role_permission` VALUES ('4', 'departManager', 'departDeleteMember');
INSERT INTO `palm_role_permission` VALUES ('5', 'president', 'admin');
INSERT INTO `palm_role_permission` VALUES ('6', 'classLeader', 'studentParentManager');
INSERT INTO `palm_role_permission` VALUES ('7', 'chairman', 'admin');
INSERT INTO `palm_role_permission` VALUES ('8', 'president', 'admin');
INSERT INTO `palm_role_permission` VALUES ('9', 'student', 'announcementManager');
INSERT INTO `palm_role_permission` VALUES ('10', 'teacher', 'announcementManager');
INSERT INTO `palm_role_permission` VALUES ('11', 'parent', 'announcementManager');
INSERT INTO `palm_role_permission` VALUES ('12', 'employee', 'announcementManager');
INSERT INTO `palm_role_permission` VALUES ('14', 'other', 'announcementManager');
INSERT INTO `palm_role_permission` VALUES ('15', 'departManager', 'departmentAnnouncementAdd');
INSERT INTO `palm_role_permission` VALUES ('16', 'classLeader', 'clazzAnnouncementAdd');
INSERT INTO `palm_role_permission` VALUES ('18', 'employee', 'myMessageManager');
INSERT INTO `palm_role_permission` VALUES ('19', 'other', 'myMessageManager');
INSERT INTO `palm_role_permission` VALUES ('20', 'parent', 'myMessageManager');
INSERT INTO `palm_role_permission` VALUES ('21', 'student', 'myMessageManager');
INSERT INTO `palm_role_permission` VALUES ('22', 'teacher', 'myMessageManager');
INSERT INTO `palm_role_permission` VALUES ('23', 'classLeader', 'sendScoreManager');
INSERT INTO `palm_role_permission` VALUES ('24', 'teacher', 'sendMessageHistoryManager');
INSERT INTO `palm_role_permission` VALUES ('25', 'employee', 'sendMessageHistoryManager');
INSERT INTO `palm_role_permission` VALUES ('27', 'departManager', 'teacherMessageManager');
INSERT INTO `palm_role_permission` VALUES ('28', 'classLeader', 'studentMessageManager');
INSERT INTO `palm_role_permission` VALUES ('29', 'teacher', 'sendOnlineMessageHistoryManager');
INSERT INTO `palm_role_permission` VALUES ('30', 'employee', 'sendOnlineMessageHistoryManager');
INSERT INTO `palm_role_permission` VALUES ('32', 'departManager', 'teacherOnlineMessageManager');
INSERT INTO `palm_role_permission` VALUES ('35', 'classLeader', 'studentOnlineMessageManager');
INSERT INTO `palm_role_permission` VALUES ('36', 'teacher', 'inoutManager');
INSERT INTO `palm_role_permission` VALUES ('37', 'student', 'inoutManager');
INSERT INTO `palm_role_permission` VALUES ('38', 'parent', 'inoutManager');
INSERT INTO `palm_role_permission` VALUES ('39', 'employee', 'inoutManager');
INSERT INTO `palm_role_permission` VALUES ('41', 'teacher', 'leaveApplyManager');
INSERT INTO `palm_role_permission` VALUES ('42', 'student', 'leaveApplyManager');
INSERT INTO `palm_role_permission` VALUES ('43', 'parent', 'leaveApplyManager');
INSERT INTO `palm_role_permission` VALUES ('44', 'employee', 'leaveApplyManager');
INSERT INTO `palm_role_permission` VALUES ('46', 'classLeader', 'leaveAuditForStudent');
INSERT INTO `palm_role_permission` VALUES ('47', 'classLeader', 'leaveAuditManager');
INSERT INTO `palm_role_permission` VALUES ('48', 'departManager', 'announcementManager');
INSERT INTO `palm_role_permission` VALUES ('49', 'classLeader', 'announcementManager');
INSERT INTO `palm_role_permission` VALUES ('50', 'classLeader', 'myMessageManager');
INSERT INTO `palm_role_permission` VALUES ('51', 'departManager', 'myMessageManager');
INSERT INTO `palm_role_permission` VALUES ('52', 'departManager', 'sendMessageHistoryManager');
INSERT INTO `palm_role_permission` VALUES ('53', 'classLeader', 'sendMessageHistoryManager');
INSERT INTO `palm_role_permission` VALUES ('54', 'departManager', 'sendOnlineMessageHistoryManager');
INSERT INTO `palm_role_permission` VALUES ('55', 'classLeader', 'sendOnlineMessageHistoryManager');
INSERT INTO `palm_role_permission` VALUES ('58', 'departManager', 'inoutManager');
INSERT INTO `palm_role_permission` VALUES ('59', 'classLeader', 'inoutManager');
INSERT INTO `palm_role_permission` VALUES ('60', 'classLeader', 'leaveApplyManager');
INSERT INTO `palm_role_permission` VALUES ('61', 'departManager', 'leaveApplyManager');
INSERT INTO `palm_role_permission` VALUES ('62', 'departManager', 'teacherAttendanceManager');
INSERT INTO `palm_role_permission` VALUES ('63', 'classLeader', 'teacherAttendanceManager');
INSERT INTO `palm_role_permission` VALUES ('64', 'teacher', 'teacherAttendanceManager');
INSERT INTO `palm_role_permission` VALUES ('65', 'employee', 'teacherAttendanceManager');
INSERT INTO `palm_role_permission` VALUES ('66', 'classLeader', 'studentAttendanceManager');
INSERT INTO `palm_role_permission` VALUES ('68', 'employee', 'studentAttendanceManager');
INSERT INTO `palm_role_permission` VALUES ('69', 'parent', 'studentAttendanceManager');
INSERT INTO `palm_role_permission` VALUES ('70', 'student', 'studentAttendanceManager');
INSERT INTO `palm_role_permission` VALUES ('71', 'teacher', 'studentAttendanceManager');
INSERT INTO `palm_role_permission` VALUES ('72', 'employee', 'meetingInoutManager');
INSERT INTO `palm_role_permission` VALUES ('73', 'teacher', 'meetingInoutManager');
INSERT INTO `palm_role_permission` VALUES ('74', 'departManager', 'meetingInoutManager');
INSERT INTO `palm_role_permission` VALUES ('75', 'classLeader', 'meetingInoutManager');
INSERT INTO `palm_role_permission` VALUES ('80', 'employee', 'meetingRecordManager');
INSERT INTO `palm_role_permission` VALUES ('81', 'teacher', 'meetingRecordManager');
INSERT INTO `palm_role_permission` VALUES ('82', 'departManager', 'meetingRecordManager');
INSERT INTO `palm_role_permission` VALUES ('83', 'classLeader', 'meetingRecordManager');
INSERT INTO `palm_role_permission` VALUES ('84', 'classLeader', 'schoolBusOnManager');
INSERT INTO `palm_role_permission` VALUES ('85', 'departManager', 'schoolBusOnManager');
INSERT INTO `palm_role_permission` VALUES ('86', 'employee', 'schoolBusOnManager');
INSERT INTO `palm_role_permission` VALUES ('87', 'parent', 'schoolBusOnManager');
INSERT INTO `palm_role_permission` VALUES ('88', 'student', 'schoolBusOnManager');
INSERT INTO `palm_role_permission` VALUES ('89', 'teacher', 'schoolBusOnManager');
INSERT INTO `palm_role_permission` VALUES ('90', 'parent', 'schoolBusSmsManager');
INSERT INTO `palm_role_permission` VALUES ('91', 'student', 'schoolBusSmsManager');
INSERT INTO `palm_role_permission` VALUES ('92', 'classLeader', 'schoolBusSmsManager');
INSERT INTO `palm_role_permission` VALUES ('93', 'classLeader', 'dormitoryManager');
INSERT INTO `palm_role_permission` VALUES ('94', 'departManager', 'dormitoryManager');
INSERT INTO `palm_role_permission` VALUES ('95', 'employee', 'dormitoryManager');
INSERT INTO `palm_role_permission` VALUES ('96', 'parent', 'dormitoryManager');
INSERT INTO `palm_role_permission` VALUES ('97', 'student', 'dormitoryManager');
INSERT INTO `palm_role_permission` VALUES ('98', 'teacher', 'dormitoryManager');
INSERT INTO `palm_role_permission` VALUES ('99', 'classLeader', 'dormitoryInoutManager');
INSERT INTO `palm_role_permission` VALUES ('100', 'parent', 'dormitoryInoutManager');
INSERT INTO `palm_role_permission` VALUES ('101', 'student', 'dormitoryInoutManager');
INSERT INTO `palm_role_permission` VALUES ('102', 'classLeader', 'dormitoryAbnormalManager');
INSERT INTO `palm_role_permission` VALUES ('103', 'classLeader', 'schoolBusReportManager');
INSERT INTO `palm_role_permission` VALUES ('104', 'classLeader', 'evaluationListManager');
INSERT INTO `palm_role_permission` VALUES ('105', 'teacher', 'evaluationListManager');
INSERT INTO `palm_role_permission` VALUES ('106', 'student', 'evaluationListManager');
INSERT INTO `palm_role_permission` VALUES ('107', 'departManager', 'evaluationListManager');
INSERT INTO `palm_role_permission` VALUES ('113', 'departManager', 'yktTotalManager');
INSERT INTO `palm_role_permission` VALUES ('114', 'classLeader', 'yktTotalManager');
INSERT INTO `palm_role_permission` VALUES ('115', 'teacher', 'yktTotalManager');
INSERT INTO `palm_role_permission` VALUES ('116', 'parent', 'yktTotalManager');
INSERT INTO `palm_role_permission` VALUES ('117', 'student', 'yktTotalManager');
INSERT INTO `palm_role_permission` VALUES ('118', 'employee', 'yktTotalManager');
INSERT INTO `palm_role_permission` VALUES ('125', 'departManager', 'createDepartGroup');
INSERT INTO `palm_role_permission` VALUES ('126', 'classLeader', 'abnormal');
INSERT INTO `palm_role_permission` VALUES ('127', 'departManager', 'abnormal');
INSERT INTO `palm_role_permission` VALUES ('128', 'employee', 'abnormal');
INSERT INTO `palm_role_permission` VALUES ('129', 'parent', 'abnormal');
INSERT INTO `palm_role_permission` VALUES ('130', 'student', 'abnormal');
INSERT INTO `palm_role_permission` VALUES ('131', 'teacher', 'abnormal');
INSERT INTO `palm_role_permission` VALUES ('132', 'classLeader', 'sysMessage');
INSERT INTO `palm_role_permission` VALUES ('133', 'departManager', 'sysMessage');
INSERT INTO `palm_role_permission` VALUES ('134', 'employee', 'sysMessage');
INSERT INTO `palm_role_permission` VALUES ('135', 'parent', 'sysMessage');
INSERT INTO `palm_role_permission` VALUES ('136', 'student', 'sysMessage');
INSERT INTO `palm_role_permission` VALUES ('137', 'teacher', 'sysMessage');
INSERT INTO `palm_role_permission` VALUES ('138', 'classLeader', 'createClazzGroup');
INSERT INTO `palm_role_permission` VALUES ('139', 'student', 'curriculumManager');
INSERT INTO `palm_role_permission` VALUES ('140', 'parent', 'curriculumManager');
INSERT INTO `palm_role_permission` VALUES ('141', 'teacher', 'curriculumManager');
INSERT INTO `palm_role_permission` VALUES ('142', 'classLeader', 'curriculumManager');
INSERT INTO `palm_role_permission` VALUES ('143', 'classLeader', 'editCurriculum');
INSERT INTO `palm_role_permission` VALUES ('144', 'classLeader', 'loadCurriculum');
INSERT INTO `palm_role_permission` VALUES ('145', 'classLeader', 'importCurriculum');
INSERT INTO `palm_role_permission` VALUES ('146', 'classLeader', 'saveCurriculum');
INSERT INTO `palm_role_permission` VALUES ('147', 'departManager', 'curriculumManager');
INSERT INTO `palm_role_permission` VALUES ('148', 'departManager', 'announcementAdd');
INSERT INTO `palm_role_permission` VALUES ('149', 'classLeader', 'announcementAdd');
INSERT INTO `palm_role_permission` VALUES ('150', 'classLeader', 'schoolNewsReleaseManager');
INSERT INTO `palm_role_permission` VALUES ('151', 'classLeader', 'schoolNewsLookManager');
INSERT INTO `palm_role_permission` VALUES ('152', 'parent', 'schoolNewsLookManager');
INSERT INTO `palm_role_permission` VALUES ('153', 'teacher', 'schoolNewsLookManager');
INSERT INTO `palm_role_permission` VALUES ('154', 'departManager', 'schoolNewsLookManager');
INSERT INTO `palm_role_permission` VALUES ('155', 'employee', 'schoolNewsLookManager');
INSERT INTO `palm_role_permission` VALUES ('156', 'other', 'schoolNewsLookManager');
INSERT INTO `palm_role_permission` VALUES ('157', 'student', 'schoolNewsLookManager');
INSERT INTO `palm_role_permission` VALUES ('158', 'parent', 'cameraManager');
INSERT INTO `palm_role_permission` VALUES ('159', 'student', 'cameraManager');
INSERT INTO `palm_role_permission` VALUES ('160', 'teacher', 'cameraManager');
INSERT INTO `palm_role_permission` VALUES ('161', 'departManager', 'cameraManager');
INSERT INTO `palm_role_permission` VALUES ('162', 'classLeader', 'cameraManager');
INSERT INTO `palm_role_permission` VALUES ('163', 'classLeader', 'studentParentModify');
INSERT INTO `palm_role_permission` VALUES ('164', 'classLeader', 'replaceRechargeManager');
INSERT INTO `palm_role_permission` VALUES ('165', 'parent', 'replaceRechargeManager');
INSERT INTO `palm_role_permission` VALUES ('166', 'classLeader', 'messageManage');
INSERT INTO `palm_role_permission` VALUES ('167', 'parent', 'messageManage');
INSERT INTO `palm_role_permission` VALUES ('168', 'parent', 'orderMessageManager');
INSERT INTO `palm_role_permission` VALUES ('169','teacher', 'securityDanger');
INSERT INTO `palm_role_permission` VALUES ('172','classLeader', 'securityDanger');
INSERT INTO `palm_role_permission` VALUES ('173','departManager', 'securityDanger');
INSERT INTO `palm_role_permission` VALUES ('174','employee', 'securityDanger');

DROP TABLE IF EXISTS `palm_scheduledetail`;
CREATE TABLE `palm_scheduledetail` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) DEFAULT '0' COMMENT '0 正常上课日期，1.休息日',
  `amstarttime` varchar(25) DEFAULT NULL,
  `amendtime` varchar(25) DEFAULT NULL,
  `pmstarttime` varchar(25) DEFAULT NULL,
  `pmendtime` varchar(25) DEFAULT NULL,
  `nightstarttime` varchar(25) DEFAULT NULL,
  `nightendtime` varchar(25) DEFAULT NULL,
  `liveingDate` date DEFAULT NULL COMMENT '生效时间 表示那一天',
  `userId` int(11) DEFAULT NULL COMMENT '用户ID',
  `type` int(11) DEFAULT '0' COMMENT '用户类型（0分段 1全天）',
  `beginTime` varchar(25) DEFAULT NULL COMMENT '上课时间',
  `endTime` varchar(25) DEFAULT NULL COMMENT '放学时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='作息时间表添加作息时间';

DROP TABLE IF EXISTS `palm_schedule_clazz`;
CREATE TABLE `palm_schedule_clazz` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) DEFAULT '0' COMMENT '0 正常上课日期，1.休息日',
  `amstarttime` varchar(25) DEFAULT NULL,
  `amendtime` varchar(25) DEFAULT NULL,
  `pmstarttime` varchar(25) DEFAULT NULL,
  `pmendtime` varchar(25) DEFAULT NULL,
  `nightstarttime` varchar(25) DEFAULT NULL,
  `nightendtime` varchar(25) DEFAULT NULL,
  `liveingDate` date DEFAULT NULL COMMENT '生效时间 表示那一天',
  `clazzId` int(11) DEFAULT NULL COMMENT '班级id',
  `gradeId` int(11) DEFAULT NULL COMMENT '年级id',
  `type` int(11) DEFAULT '0' COMMENT '用户类型（0分段，1整天)',
  `beginTime` varchar(25) DEFAULT NULL COMMENT '开始时间(整天类型)',
  `endTime` varchar(25) DEFAULT NULL COMMENT '结束时间(整天类型)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='班级作息时间表添加作息时间';

DROP TABLE IF EXISTS `palm_schedule_teacher`;
CREATE TABLE `palm_schedule_teacher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) DEFAULT '0' COMMENT '0 正常上课日期，1.休息日',
  `amstarttime` varchar(25) DEFAULT NULL,
  `amendtime` varchar(25) DEFAULT NULL,
  `pmstarttime` varchar(25) DEFAULT NULL,
  `pmendtime` varchar(25) DEFAULT NULL,
  `nightstarttime` varchar(25) DEFAULT NULL,
  `nightendtime` varchar(25) DEFAULT NULL,
  `liveingDate` date DEFAULT NULL COMMENT '生效时间 表示那一天',
  `teacherId` int(11) DEFAULT NULL COMMENT '教师id',
  `type` int(11) DEFAULT '0' COMMENT '用户类型（0分段，1整天)',
  `beginTime` varchar(25) DEFAULT NULL COMMENT '开始时间(整天类型)',
  `endTime` varchar(25) DEFAULT NULL COMMENT '结束时间(整天类型)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='作息时间表添加作息时间';

DROP TABLE IF EXISTS `palm_schedule_time`;
CREATE TABLE `palm_schedule_time` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `beginTime` varchar(25) DEFAULT NULL COMMENT '开始时间',
  `endTime` varchar(25) DEFAULT NULL COMMENT '结束时间',
  `type` varchar(25) DEFAULT NULL COMMENT '0全天 1上午 2下午 3晚上',
  `createTime` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='作息时间段表';

DROP TABLE IF EXISTS `palm_schedule_time_relation`;
CREATE TABLE `palm_schedule_time_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `scheduleId` int(11) DEFAULT NULL COMMENT '作息表id',
  `timeId` int(11) DEFAULT NULL COMMENT '时间段id',
  `createTime` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='作息时间和时间段关系表';

DROP TABLE IF EXISTS `palm_school_activity_apply_info`;
CREATE TABLE `palm_school_activity_apply_info` (
  `infoId` int(11) NOT NULL AUTO_INCREMENT COMMENT '信息Id',
  `name` varchar(32) DEFAULT NULL COMMENT '学生姓名',
  `sex` int(1) DEFAULT NULL COMMENT '性别 0男 1女',
  `schoolYear` varchar(32) DEFAULT NULL COMMENT '入学年份',
  `linkMan` varchar(32) DEFAULT NULL COMMENT '联系人',
  `linkPhone` varchar(32) DEFAULT NULL COMMENT '联系电话',
  `childNum` INT(11) NULL COMMENT '参加儿童人数',
  `adultNum` int(11) NULL COMMENT '参加大人人数',
  `createTime` VARCHAR(32) NULL COMMENT '创建时间',
  `schoolId` VARCHAR(255) NULL   COMMENT '学校id',
  `newsId` INT(11) NULL   COMMENT '活动对应的Id',
  PRIMARY KEY (`infoId`),
  KEY `name_index` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='校园活动参加信息表'; 

DROP TABLE IF EXISTS `palm_school_news`;
CREATE TABLE `palm_school_news` (
  `newsId` INT(11) NOT NULL AUTO_INCREMENT,
  `newsType` INT(11) DEFAULT NULL COMMENT '1 校园类型 2学校活动 3 校园招生信息   4 家长课堂',
  `newsTitle` VARCHAR(255) DEFAULT NULL COMMENT '新闻标题',
  `newsAuthor` VARCHAR(32) DEFAULT NULL COMMENT '新闻作者',
  `newsContent` TEXT COMMENT '新闻的正文',
  `newsCover` VARCHAR(255) DEFAULT NULL COMMENT '新闻封面 保存的是图片路径',
  `newsDigest` VARCHAR(255) DEFAULT NULL COMMENT '新闻摘要',
  `phone` VARCHAR(32) DEFAULT NULL COMMENT '发布招生信息时  添加一键拨号号码',
  `newsRanye` VARCHAR(1000) DEFAULT NULL COMMENT '新闻发布的范围T0表示全校教职工 P0全部家长 G开头表示年级 C开头表示班级',
  `schoolId` VARCHAR(32) DEFAULT NULL COMMENT '学校的Id  用于区分本条新闻是那个学校发布的',
  `createUserId` INT(11) DEFAULT NULL COMMENT '新闻发布人的Id',
  `createUserName` VARCHAR(32) DEFAULT NULL COMMENT '新闻发布人姓名',
  `createTime` VARCHAR(32) DEFAULT NULL COMMENT '新闻发布的时间',
  `functionType` INT(2) DEFAULT '0' COMMENT '默认0 表示没有电话和我要报名功能  1只有我要咨询功能 2 只有我要报名功能  3两者都有',
  `status` INT(2) DEFAULT NULL COMMENT '新闻发布状态 1发布 2下线',
  PRIMARY KEY (`newsId`)
) ENGINE=INNODB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COMMENT='校园发布的新闻 活动 招生信息';

DROP TABLE IF EXISTS `palm_school_news_comment`;
CREATE TABLE `palm_school_news_comment` (
  `commentId` INT(11) NOT NULL AUTO_INCREMENT COMMENT '评论Id',
  `parentId` INT(11) DEFAULT '0' COMMENT '父评论的id',
  `commentType` INT(11) DEFAULT NULL COMMENT '评论类型 0 点赞  1 文字回复',
  `content` VARCHAR(1000) DEFAULT NULL COMMENT '评论内容',
  `commentUserId` INT(11) DEFAULT NULL COMMENT '评论人Id',
  `commentUserName` VARCHAR(32) DEFAULT NULL COMMENT '评论姓名',
  `createTime` VARCHAR(32) DEFAULT NULL COMMENT '评论时间',
  `newsId` INT(11) DEFAULT NULL COMMENT '校园新闻id',
  `commentReplyId` INT(11) DEFAULT '0' COMMENT '回复评论的id',
  `commentReplyUserId` INT(11) DEFAULT '0' COMMENT '回复评论的userId',
  `commentReplyUserName` VARCHAR(32) DEFAULT NULL COMMENT '回复评论的姓名',
  `zanCount` INT(11) DEFAULT '0',
  `replayCount` INT(11) DEFAULT '0',
  PRIMARY KEY (`commentId`)
) ENGINE=INNODB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COMMENT='校园新闻评论表';

DROP TABLE IF EXISTS `palm_school_news_apply_info`;
CREATE TABLE `palm_school_news_apply_info` (
  `id` INT(12) NOT NULL AUTO_INCREMENT,
  `schoolId` VARCHAR(12) DEFAULT NULL COMMENT '学校Id',
  `referrer` VARCHAR(32) DEFAULT NULL COMMENT '推荐人',
  `address` VARCHAR(255) DEFAULT NULL COMMENT '家庭住址',
  `username` VARCHAR(12) DEFAULT NULL,
  `birth` VARCHAR(24) DEFAULT NULL,
  `sex` VARCHAR(1) DEFAULT NULL COMMENT '0男 1女',
  `phone` VARCHAR(16) DEFAULT NULL,
  `createTime` VARCHAR(32) DEFAULT NULL,
  `status` VARCHAR(1) DEFAULT NULL,
  `newsId` VARCHAR(12) DEFAULT NULL COMMENT '新闻Id',
  `remark` VARCHAR(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='报名申请人信息表 校园发布的招生信息时有我要报名入口 报名人填写基本信息 ';

DROP TABLE IF EXISTS `palm_schoolbus_abnormal`;
CREATE TABLE `palm_schoolbus_abnormal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(96) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '1上校车 2下车',
  `message` varchar(768) DEFAULT NULL,
  `sentTime` datetime DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='校车打卡异常统计表 根据校车打卡记录表 打卡是否正常 上学打卡顺序：司机家长孩子 放学:司机孩子家长';

DROP TABLE IF EXISTS `palm_schoolbus_abnormal_detail`;
CREATE TABLE `palm_schoolbus_abnormal_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `time` date DEFAULT NULL COMMENT '格式是yyyy-mm-dd  用于判定是那一天的',
  `gradeId` int(11) DEFAULT NULL,
  `clazzId` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '1上车 2 下车',
  `positionId` int(11) DEFAULT NULL,
  `positionTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='校车异常详情表,此表用于存储异常详情表 用于校车统计  显示具体的人员信息';

DROP TABLE IF EXISTS `palm_schoolbus_abnormal_total`;
CREATE TABLE `palm_schoolbus_abnormal_total` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sum` int(11) DEFAULT NULL,
  `sumAbnormal` int(11) DEFAULT NULL,
  `time` date DEFAULT NULL COMMENT '统计时间 yyyy-dd-mm',
  `type` int(11) DEFAULT NULL COMMENT '1上车 2下车',
  `scale` int(11) DEFAULT NULL COMMENT '0:按学校统计  1:按年级统计  2:按班级统计',
  `itemId` int(11) DEFAULT NULL COMMENT '学校,年级,班级的主键  scale=0 表示学校ID scale=1 表示年级Id  scale = 2 表示班级Id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='校车统计总表,用于校车统计图形显示表';

DROP TABLE IF EXISTS `palm_schoolbus_inout`;
CREATE TABLE `palm_schoolbus_inout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '1上车 2下车 （学生上学下车打卡放学上车打卡  家长送孩子上学打卡 接到孩子打卡  司机在家长学生之前打卡）',
  `position` varchar(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `sync` tinyint(3) DEFAULT NULL,
  `driverName` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='校车打卡进出记录表,存储校车打卡信息记录表';
ALTER TABLE `palm_schoolbus_inout` ADD INDEX `PK_USERID` (`userId`) ;

DROP TABLE IF EXISTS `palm_schoolbus_schedule`;
CREATE TABLE `palm_schoolbus_schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `day` date DEFAULT NULL,
  `startTime` varchar(32) DEFAULT NULL,
  `endTime` varchar(32) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '1 回家上车 2 上学下车',
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_day` (`day`),
  KEY `index_startTime` (`startTime`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='校车信息详情表,存储家长接到孩子后的信息';

DROP TABLE IF EXISTS `palm_schoolbus_sms_detail`;
CREATE TABLE `palm_schoolbus_sms_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(768) DEFAULT NULL,
  `receiverId` int(11) DEFAULT NULL,
  `receiverName` varchar(96) DEFAULT NULL,
  `phone` varchar(96) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='校车信息详情表,存储家长接到孩子后的信息';
ALTER TABLE `palm_schoolbus_sms_detail` ADD INDEX `PK_USERID` (`receiverId`) ;

DROP TABLE IF EXISTS `palm_selfgrowth`;
CREATE TABLE `palm_selfgrowth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL COMMENT '用户ID',
  `templateId` int(11) NOT NULL COMMENT '模板ID',
  `gradeName` varchar(10) DEFAULT NULL COMMENT '年级',
  `term` int(11) DEFAULT '0' COMMENT '学期 0 上学期 1下学期',
  `createTime` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COMMENT='个人成长档案';

DROP TABLE IF EXISTS `palm_sms`;
CREATE TABLE `palm_sms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(500) NOT NULL COMMENT '短信内容',
  `senderId` int(11) NOT NULL COMMENT '发送人id',
  `senderName` varchar(20) NOT NULL COMMENT '发送者名称',
  `module` int(11) NOT NULL COMMENT '1:教师 2:学生',
  `smsLength` int(11) NOT NULL DEFAULT '0' COMMENT '短信长度',
  `phoneCount` int(11) DEFAULT '0' COMMENT '收短信手机数量，多号码合入',
  `result` int(11) NOT NULL DEFAULT '0' COMMENT '短信处理结果',
  `reportAmount` int(11) NOT NULL DEFAULT '0',
  `succAmount` int(11) NOT NULL DEFAULT '0',
  `sentTime` datetime DEFAULT NULL COMMENT '发送时间',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `isRealTime` varchar(2) DEFAULT NULL COMMENT '是否实时 0：定时发送  1：实时发送',
  `type` varchar(2) DEFAULT NULL COMMENT '发送短信类型，0:教师短信服务 1:学生短信服务 2:成绩下发 3:会议通知 4:校车 5:作业发送',
  `smsSum` int(11) DEFAULT '0' COMMENT '发送短信总数',
  `errorSmsSum` int(11) DEFAULT '0' COMMENT '发送失败数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='发送短信表';
ALTER TABLE `palm_sms` ADD INDEX `PK_USERID` (`senderId`) ;

DROP TABLE IF EXISTS `palm_sms_backup`;
CREATE TABLE `palm_sms_backup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(500) NOT NULL COMMENT '短信内容',
  `senderId` int(11) NOT NULL COMMENT '发送人id',
  `senderRoleid` int(11) DEFAULT NULL COMMENT '发送者权限ID',
  `module` int(11) NOT NULL COMMENT '1:教师 2:学生',
  `smsLength` int(11) NOT NULL DEFAULT '0' COMMENT '短信长度',
  `phoneCount` int(11) NOT NULL DEFAULT '0' COMMENT '收短信手机数量，多号码合入',
  `receiver` text NOT NULL,
  `result` int(11) NOT NULL DEFAULT '0' COMMENT '短信处理结果',
  `reportAmount` int(11) NOT NULL DEFAULT '0',
  `succAmount` int(11) NOT NULL DEFAULT '0',
  `sentTime` datetime DEFAULT NULL COMMENT '发送时间',
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `isRealTime` varchar(2) DEFAULT NULL COMMENT '是否实时 0：定时发送  1：实时发送',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='发送短信表备份';

DROP TABLE IF EXISTS `palm_sms_detail`;
CREATE TABLE `palm_sms_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(500) NOT NULL,
  `senderId` int(11) NOT NULL,
  `senderName` varchar(32) DEFAULT NULL,
  `receiverId` int(11) NOT NULL,
  `phone` varchar(32) DEFAULT NULL,
  `receiverName` varchar(32) DEFAULT NULL,
  `seq` varchar(64) DEFAULT NULL,
  `report` varchar(32) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0:成功 1:发送失败 2:未缴纳服务费',
  `smsId` int(11) DEFAULT NULL,
  `reportTime` datetime DEFAULT NULL,
  `createTime` datetime NOT NULL,
  `type` varchar(2) DEFAULT NULL COMMENT '发送短信类型，0:教师短信服务 1:学生短信服务 2:成绩下发 3:会议通知 4:校车 5:校门 6:一卡通  7 公告 8 宿舍  9请假',
  `sentTime` datetime DEFAULT NULL COMMENT '发送时间',
  PRIMARY KEY (`id`),
  KEY `index_receiverid` (`receiverId`),
  KEY `index_conetnt` (`content`(255)),
  KEY `index_smsid` (`smsId`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;
ALTER TABLE `palm_sms_detail` ADD INDEX `PK_USERID` (`senderId`) ;

DROP TABLE IF EXISTS `palm_stat`;
CREATE TABLE `palm_stat` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `code` varchar(32) NOT NULL COMMENT '卡号',
  `inTime` varchar(100) DEFAULT NULL COMMENT '进校时间',
  `outTime` varchar(100) DEFAULT NULL COMMENT '出校事假',
  `userId` int(11) DEFAULT NULL COMMENT '用户id',
  `hours` float NOT NULL DEFAULT '0' COMMENT '在校时长',
  PRIMARY KEY (`id`),
  KEY `index_userid` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='在校时间统计表';

DROP TABLE IF EXISTS `palm_student_clazz`;
CREATE TABLE `palm_student_clazz` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户角色表主键',
  `userId` int(11) DEFAULT NULL COMMENT '用户表主键',
  `clazzId` int(11) DEFAULT NULL COMMENT '班级表主键',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='学生班级关系表';
ALTER TABLE `palm_student_clazz` ADD INDEX `PK_USERID` (`userId`) ;

DROP TABLE IF EXISTS `palm_student_grow`;
CREATE TABLE `palm_student_grow` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `picture` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `createtime` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `palm_subject`;
CREATE TABLE `palm_subject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subjectname` varchar(30) DEFAULT NULL COMMENT '科目',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `palm_subjectandteacherlink`;
CREATE TABLE `palm_subjectandteacherlink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subjectId` int(11) NOT NULL COMMENT '科目ID',
  `clazzId` int(11) NOT NULL COMMENT '班级ID',
  `teacherId` int(11) NOT NULL COMMENT '老师ID',
  `createTime` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COMMENT='科目老师关系表,成绩分析使用';

DROP TABLE IF EXISTS `palm_syllabus`;
CREATE TABLE `palm_syllabus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL,
  `subjectName` varchar(32) DEFAULT NULL,
  `clazzid` int(11) DEFAULT NULL,
  `subjectUserId` int(11) DEFAULT NULL,
  `cycle` int(11) DEFAULT NULL,
  `joint` int(11) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS palm_sys_message;
CREATE TABLE palm_sys_message
(
   id                   BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键',
   userId               INT(10) COMMENT '用户ID',
   TYPE                 INT(1) COMMENT '类型：0推送 1短信',
   messageType          INT(2) COMMENT '消息类型：1校园公告，2在线请假，3会议通知，4宿舍通知，5校车通知, 6短信平台，7成绩通知, 8进出校园',
   content              VARCHAR(1000) COMMENT '内容',
   createTime           DATETIME COMMENT '创建时间',
   PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COMMENT='系统消息表';
ALTER TABLE `palm_sys_message` ADD INDEX `PK_USERID` (`userId`) ;

DROP TABLE IF EXISTS `palm_system_log`;
CREATE TABLE `palm_system_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL COMMENT '用户id',
  `ip` varchar(32) NOT NULL COMMENT 'ip地址',
  `operation` int(11) NOT NULL COMMENT '操作',
  `introduction` varchar(512) NOT NULL COMMENT '操作内容',
  `createTime` datetime NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统日志表';

DROP TABLE IF EXISTS `palm_task_history`;
CREATE TABLE `palm_task_history` (
  `historyId` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `taskSubjectId` int(11) DEFAULT NULL COMMENT '科目id',
  `taskContent` varchar(1000) DEFAULT NULL COMMENT '科目作业内容',
  `taskContentImage` varchar(200) DEFAULT NULL COMMENT '科目作业内容图片',
  `createDate` date DEFAULT NULL COMMENT '作业发布时间',
  `clazzId` int(11) DEFAULT NULL COMMENT '班级Id',
  `sendUserId` int(11) DEFAULT NULL COMMENT '作业发送人',
  `sendUserName` varchar(20) DEFAULT NULL COMMENT '作业发送人姓名',
  `createTime` varchar(25) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`historyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='作业发送记录';

DROP TABLE IF EXISTS `palm_task_history_detail`;
CREATE TABLE `palm_task_history_detail` (
  `detailId` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `historyId` int(11) DEFAULT NULL COMMENT 'history表主键',
  `reciveUserId` int(11) DEFAULT NULL COMMENT '作业接收人(存储的是学生Id)',
  `createDate` date DEFAULT NULL COMMENT '发布作业时间',
  `reciveUserName` varchar(36) DEFAULT NULL COMMENT '接收人姓名',
  `createTime` varchar(25) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`detailId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='作业发送接收人列表';

DROP TABLE IF EXISTS `palm_task_subject`;
CREATE TABLE `palm_task_subject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subjectname` varchar(30) DEFAULT NULL COMMENT '科目',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='作业助手科目表';

DROP TABLE IF EXISTS `palm_teacher_award`;
CREATE TABLE `palm_teacher_award` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `palm_teacher_evaluate_detail`;
CREATE TABLE `palm_teacher_evaluate_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modelId` int(11) DEFAULT NULL COMMENT '模型ID',
  `titleId` int(11) DEFAULT NULL COMMENT '评价标题ID',
  `text` varchar(255) DEFAULT NULL COMMENT '选项内容',
  `level` int(11) DEFAULT NULL COMMENT '给予老师评价等级',
  `formId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生对老师评价选项详情表';

DROP TABLE IF EXISTS `palm_teacher_evaluate_form`;
CREATE TABLE `palm_teacher_evaluate_form` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modelId` int(11) DEFAULT NULL COMMENT '模型ID',
  `name` varchar(50) DEFAULT NULL COMMENT '评价名称',
  `gradeId` int(10) DEFAULT NULL COMMENT '嫡属于年级',
  `clazzId` int(10) DEFAULT NULL COMMENT '嫡属于班级',
  `type` varchar(255) DEFAULT NULL COMMENT '分类',
  `userId` int(11) DEFAULT NULL,
  `sid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生对老师评价信息表单表';

DROP TABLE IF EXISTS `palm_teacher_evaluate_phrase`;
CREATE TABLE `palm_teacher_evaluate_phrase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `formId` int(11) DEFAULT NULL COMMENT '评价表单表ID',
  `titleId` int(11) DEFAULT NULL COMMENT '评价标题ID',
  `modelId` int(11) DEFAULT NULL COMMENT '模型ID',
  `text` varchar(999) DEFAULT NULL COMMENT '对老师评价的常用短语',
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生对老师评价短语表';

DROP TABLE IF EXISTS `palm_teacher_evaluate_title`;
CREATE TABLE `palm_teacher_evaluate_title` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `formId` int(11) DEFAULT NULL COMMENT '评价表单表ID',
  `modelId` int(11) DEFAULT NULL COMMENT '模型ID',
  `title` varchar(255) DEFAULT NULL COMMENT '评价标题',
  `formType` varchar(255) DEFAULT NULL COMMENT '内容分类',
  `contextType` varchar(255) DEFAULT NULL COMMENT '内容分类',
  `titleType` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生对老师评价信息标题表';

DROP TABLE IF EXISTS `palm_teacher_honor`;
CREATE TABLE `palm_teacher_honor` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `palm_teacher_research`;
CREATE TABLE `palm_teacher_research` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `palm_teaching_resources`;
CREATE TABLE `palm_teaching_resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fileName` varchar(50) DEFAULT NULL COMMENT '文件名称',
  `uploadUserId` int(11) DEFAULT NULL COMMENT '上传者userId',
  `userName` varchar(50) DEFAULT NULL COMMENT '上传者名称',
  `fileSize` varchar(10) DEFAULT NULL COMMENT '文件大小',
  `createTime` varchar(20) DEFAULT NULL COMMENT '上传时间',
  `taskSubjectId` int(11) DEFAULT NULL COMMENT '科目id',
  `taskSubjectName` varchar(50) DEFAULT NULL COMMENT '科目名称',
  `taskContentImage` varchar(100) DEFAULT NULL COMMENT '作业内容图片',
  `taskContent` varchar(5000) DEFAULT NULL COMMENT '作业内容',
  `createDate` varchar(20) DEFAULT NULL COMMENT '作业发布时间',
  `clazzId` int(11) DEFAULT NULL COMMENT '班级id',
  `sendUserId` int(11) DEFAULT NULL COMMENT '作业发送人',
  `sendUserName` varchar(50) DEFAULT NULL COMMENT '作业发送人姓名',
  `fileUrl` varchar(100) DEFAULT NULL COMMENT '资源路径',
  `fileType` int(2) DEFAULT NULL COMMENT '文件类型(1:视频，2：办公类型,3:压缩包，4：图片，5：音频，6：其他)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COMMENT='教学资源';

DROP TABLE IF EXISTS `palm_total`;
CREATE TABLE `palm_total` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usertype` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `periodtype` int(11) DEFAULT NULL,
  `period` varchar(32) DEFAULT NULL,
  `periodTime` varchar(100) DEFAULT NULL,
  `code` varchar(32) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `objid` int(11) DEFAULT NULL,
  `clazzid` int(11) DEFAULT '0',
  `gradeid` int(11) DEFAULT '0',
  `latetimes` int(11) DEFAULT '0',
  `leavetimes` int(11) DEFAULT '0',
  `arrivaltime` varchar(100) DEFAULT NULL,
  `leavetime` varchar(100) DEFAULT NULL,
  `hours` float DEFAULT '0',
  `createTime` datetime DEFAULT NULL,
  `affairleave` int(11) DEFAULT '0',
  `sickleave` int(11) DEFAULT '0',
  `maternityleave` int(11) DEFAULT '0',
  `businesstrip` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `palm_total_count`;
CREATE TABLE `palm_total_count` (
  `totalCount` int(11) DEFAULT NULL COMMENT 'palm_total表总数'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `palm_upload_records`;
CREATE TABLE `palm_upload_records` (
  `recordsId` int(11) NOT NULL AUTO_INCREMENT COMMENT '上传记录Id',
  `recordsDesc` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `albumId` int(11) NOT NULL COMMENT '对应的相册Id',
  `uploadUserId` int(11) DEFAULT NULL COMMENT '上传人的Id',
  `uploadUserName` varchar(32) DEFAULT NULL COMMENT '上传人姓名',
  `createTime` varchar(32) DEFAULT NULL COMMENT '上传时间',
  `recordsType` int(1) DEFAULT NULL COMMENT '类型 0文本 1图片 2音频 3视屏 4签到 5连接',
  `recordsTitle` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '标题',
  `recordsLongitude` double DEFAULT NULL COMMENT '经度',
  `recordsLatitude` double DEFAULT NULL COMMENT '纬度',
  `recordsAddress` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '地址',
  `recordsUrl` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '连接',
  PRIMARY KEY (`recordsId`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='相片上传记录表 一条记录下可以有多个相片  一个相册Id下可以有多个记录';

DROP TABLE IF EXISTS `palm_user_card`;
CREATE TABLE `palm_user_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userId` int(11) DEFAULT NULL COMMENT '用户ID',
  `cardId` int(11) DEFAULT NULL COMMENT '卡ID',
  PRIMARY KEY (`id`),
  KEY `index_cardid` (`cardId`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='用户和卡关系表';
ALTER TABLE `palm_user_card` ADD INDEX `PK_USERID` (`userId`) ;

DROP TABLE IF EXISTS `palm_user_department`;
CREATE TABLE `palm_user_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户角色表主键',
  `userId` int(11) DEFAULT NULL COMMENT '用户表主键',
  `departmentId` int(11) DEFAULT NULL COMMENT '部门表主键',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户部门关系表';
ALTER TABLE `palm_user_department` ADD INDEX `PK_USERID` (`userId`) ;

DROP TABLE IF EXISTS `palm_user_detail`;
CREATE TABLE `palm_user_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `growthId` int(11) NOT NULL COMMENT '成长档案ID',
  `userId` int(11) NOT NULL COMMENT '用户ID',
  `zoodiac` varchar(10) DEFAULT NULL COMMENT '生肖',
  `bloodType` varchar(10) DEFAULT NULL COMMENT '血型',
  `englishName` varchar(50) DEFAULT NULL COMMENT '英文名',
  `favorite` varchar(150) DEFAULT NULL COMMENT '爱好',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `imgPath` varchar(1000) DEFAULT NULL COMMENT '相片地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COMMENT='宝贝档案';

DROP TABLE IF EXISTS `palm_user_permission`;
CREATE TABLE `palm_user_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户权限表主键',
  `userId` int(11) DEFAULT NULL COMMENT '用户表主键',
  `permissionCode` varchar(32) DEFAULT NULL COMMENT '权限表主键',
  `optClazzId` varchar(50) DEFAULT NULL COMMENT '待操作班级ID',
  `optDepartId` varchar(50) DEFAULT NULL COMMENT '待操作部门ID',
  `roleCode` varchar(32) DEFAULT NULL COMMENT '权限对应的角色',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='用户权限关系表';
ALTER TABLE `palm_user_permission` ADD INDEX `PK_USERID` (`userId`) ;

DROP TABLE IF EXISTS `palm_user_role`;
CREATE TABLE `palm_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户角色表主键',
  `userId` int(11) DEFAULT NULL COMMENT '用户表主键',
  `roleCode` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '角色表主键',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户角色关系表';
ALTER TABLE `palm_user_role` ADD INDEX `PK_USERID` (`userId`) ;

DROP TABLE IF EXISTS `palm_userattendance`;
CREATE TABLE `palm_userattendance` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) DEFAULT NULL COMMENT '用户名',
  `userId` int(11) DEFAULT NULL COMMENT '用户ID',
  `type` int(11) DEFAULT '1' COMMENT '1 老师 2学生',
  `status` int(11) DEFAULT '1' COMMENT '1正常 2迟到 3早退 4（2,3同时满）5 未检测到进校，6未检测到出校 7全天未检测到信息 8休假',
  `firstInTime` datetime DEFAULT NULL COMMENT '第一次进校时间',
  `lastOutTime` datetime DEFAULT NULL COMMENT '最后一次出校时间',
  `createDate` datetime DEFAULT NULL COMMENT '创建时间',
  `outStatus` int(11) DEFAULT '1' COMMENT '1 正常，2迟到，3未读到',
  `inStatus` int(11) DEFAULT '1' COMMENT '1 正常 2迟到，3未读到 4出差 5事假 6病假',
  `other` int(11) DEFAULT NULL COMMENT '其他状态 1 普通周末假如，2 国家法定假日 3寒假或暑假',
  `week` int(11) DEFAULT NULL COMMENT '1970 到今天共有多少个周',
  `weekDay` int(11) DEFAULT NULL COMMENT '本周星期几 1 周一 2周二 。。。。 7 周日',
  `day` int(11) DEFAULT NULL COMMENT '当前的日期 天 1 号 2号 3号 。。。。31号',
  `year` int(11) DEFAULT NULL COMMENT '年',
  `month` int(11) DEFAULT NULL COMMENT '月',
  `correct` tinyint(3) DEFAULT NULL COMMENT '是否订正过。',
  PRIMARY KEY (`id`),
  KEY `查询条件` (`userId`,`week`,`status`,`createDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户考勤信息统计';

DROP TABLE IF EXISTS `palm_week`;
CREATE TABLE `palm_week` (
  `id` int(11) NOT NULL,
  `weekName` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
INSERT INTO `palm_week` VALUES (1,'星期一');
INSERT INTO `palm_week` VALUES (2,'星期二');
INSERT INTO `palm_week` VALUES (3,'星期三');
INSERT INTO `palm_week` VALUES (4,'星期四');
INSERT INTO `palm_week` VALUES (5,'星期五');
INSERT INTO `palm_week` VALUES (6,'星期六');
INSERT INTO `palm_week` VALUES (7,'星期日');

DROP TABLE IF EXISTS `palm_ykt`;
CREATE TABLE `palm_ykt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cardCode` varchar(32) DEFAULT NULL COMMENT '卡号',
  `userId` int(11) DEFAULT NULL COMMENT '用户Id',
  `userName` varchar(32) DEFAULT NULL COMMENT '用户姓名',
  `consMoney` double DEFAULT NULL COMMENT '消费金额',
  `balance` double DEFAULT NULL COMMENT '余额',
  `oldMoney` double DEFAULT NULL COMMENT '原余额',
  `consTime` datetime DEFAULT NULL COMMENT '消费时间',
  `consStatus` varchar(32) DEFAULT NULL COMMENT '消费类型 0－消费，1－存款，2－取款，3－补助, 4－挂失，5－解挂，6－开户，7－撤户，8－纠错，9－换卡，10－补卡，11－变更，12－登陆，13－正常退出，14－非法退出  21—补助清零',
  `consPlace` varchar(32) DEFAULT NULL COMMENT '消费地点',
  `clazzId` int(11) DEFAULT NULL COMMENT '班级Id',
  `departmentId` int(11) DEFAULT NULL COMMENT '部门Id',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `palm_ykt_error`;
CREATE TABLE `palm_ykt_error` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cardCode` varchar(32) DEFAULT NULL COMMENT '卡号',
  `userId` int(11) DEFAULT NULL COMMENT '用户Id',
  `userName` varchar(32) DEFAULT NULL COMMENT '用户姓名',
  `consMoney` double DEFAULT NULL COMMENT '消费金额',
  `balance` double DEFAULT NULL COMMENT '余额',
  `oldMoney` double DEFAULT NULL COMMENT '原余额',
  `consTime` datetime DEFAULT NULL COMMENT '消费时间',
  `consStatus` varchar(32) DEFAULT NULL COMMENT '消费类型 0－消费，1－存款，2－取款，3－补助, 4－挂失，5－解挂，6－开户，7－撤户，8－纠错，9－换卡，10－补卡，11－变更，12－登陆，13－正常退出，14－非法退出  21—补助清零',
  `consPlace` varchar(32) DEFAULT NULL COMMENT '消费地点',
  `clazzId` int(11) DEFAULT NULL COMMENT '班级Id',
  `departmentId` int(11) DEFAULT NULL COMMENT '部门Id',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=192 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `palm_ykt_place`;
CREATE TABLE `palm_ykt_place` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consPlace` varchar(32) DEFAULT NULL,
  `updateTime` varchar(32) DEFAULT NULL,
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `pointinfo`;
CREATE TABLE `pointinfo` (
  `id` varchar(128) NOT NULL DEFAULT '',
  `x` varchar(32) DEFAULT NULL,
  `y` varchar(32) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `temperature` varchar(12) DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `carId` varchar(36) DEFAULT NULL,
  `userId` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `studentexercisesdetail`;
CREATE TABLE `studentexercisesdetail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `exId` int(11) DEFAULT NULL COMMENT '嫡属于题目的ID',
  `text` varchar(255) DEFAULT NULL COMMENT '答案或者是参考答案',
  `type` varchar(255) DEFAULT NULL COMMENT '类型',
  `length` int(11) DEFAULT NULL COMMENT '字符长度',
  `answer` varchar(255) DEFAULT NULL COMMENT '该答案的结果',
  `comment` varchar(255) DEFAULT NULL COMMENT '介绍说明',
  `integral` varchar(255) DEFAULT NULL COMMENT '该题分数',
  `score` varchar(255) DEFAULT NULL COMMENT '该题的得分',
  `myAnswer` varchar(255) DEFAULT NULL COMMENT '我的回答',
  `updateTime` varchar(50) DEFAULT NULL COMMENT '更新时间',
  `status` int(11) DEFAULT NULL COMMENT '状态 1启用 2停用 3 存档',
  `modelId` int(11) DEFAULT NULL COMMENT '模型ID',
  `userId` int(11) DEFAULT NULL COMMENT '用户ID',
  `clickNumber` int(11) DEFAULT NULL COMMENT '点击次数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生练习题详情';

DROP TABLE IF EXISTS `teachingexercises`;
CREATE TABLE `teachingexercises` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `paperId` int(11) DEFAULT NULL COMMENT '测试卷id',
  `exFolderId` int(11) DEFAULT NULL COMMENT '题目文件夹Id',
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '题目名称',
  `contentType` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '题目类型',
  `type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '题目类型',
  `createTime` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建时间',
  `comment` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '介绍说明',
  `integral` int(11) DEFAULT NULL COMMENT '该题分数',
  `updateTime` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新时间',
  `status` int(11) DEFAULT '1' COMMENT '状态1启用2禁用',
  `answer` text CHARACTER SET utf8 COMMENT '正确答案',
  `score` int(11) DEFAULT NULL COMMENT '得分',
  `html` text COLLATE utf8mb4_general_ci COMMENT '题目内容的ＨＴＭＬ格式',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='教学练习题';

DROP TABLE IF EXISTS `teachingexercisesdetail`;
CREATE TABLE `teachingexercisesdetail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `exId` int(11) DEFAULT NULL COMMENT '嫡属于题目的ID',
  `text` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '题目内容',
  `type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '类型',
  `length` int(11) DEFAULT NULL COMMENT '字符长度',
  `answer` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '该答案的结果',
  `comment` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '介绍说明',
  `integral` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '分数',
  `updateTime` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新时间',
  `status` int(11) DEFAULT NULL COMMENT '状态 1启用 2停用 3存档',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='教学练习题';

DROP TABLE IF EXISTS `teachingexercisesfolder`;
CREATE TABLE `teachingexercisesfolder` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `parentId` int(11) DEFAULT NULL COMMENT '父节点Id',
  `subjectId` int(11) DEFAULT NULL COMMENT '科目Id',
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '文件夹名称',
  `contentType` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '题目内容类型 填空题，选择题，主观题',
  `schoolStructureId` int(11) DEFAULT NULL COMMENT '嫡属于组',
  `userId` int(11) DEFAULT NULL COMMENT '创建用户Id',
  `createTime` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建时间',
  `comment` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '对该题目文件的说明',
  `type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '题目科目类型',
  `limitTime` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '限时',
  `updateTime` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新时间',
  `status` int(11) DEFAULT '2' COMMENT '状态1启用2禁用3存档 4老师选择全班学生一起开始答题',
  `totalScore` int(11) DEFAULT NULL COMMENT '该卷子的分数',
  `semester` int(11) DEFAULT NULL COMMENT '1上学期 2下学期',
  `examSubjectId` int(11) DEFAULT NULL COMMENT '学校统考科目ID',
  `startTime` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `stopTime` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='教学练习文件夹';

DROP TABLE IF EXISTS `user_data_change_records`;
CREATE TABLE `user_data_change_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `objectId` int(11) NOT NULL COMMENT '操作对象Id',
  `oprateType` char(1) NOT NULL COMMENT '操作类型：0 add、1 update、2 delete',
  `ctime` datetime NOT NULL COMMENT '此条记录生成时间',
  `status` char(1) NOT NULL DEFAULT '0' COMMENT '同步状态：0 未同步，1 已同步',
  `failCount` tinyint(11) NOT NULL DEFAULT '0' COMMENT '同步失败次数',
  `syncTarget` char(1) NOT NULL COMMENT '同步对象：1学生,2老师,3班级,4年级',
  `syncTime` datetime DEFAULT NULL COMMENT '同步时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户操作日志表';

DROP TABLE IF EXISTS `user_data_change_records_detail`;
CREATE TABLE `user_data_change_records_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '变动记录详细表id',
  `targetId` int(11) NOT NULL COMMENT '用户操作记录表id',
  `operationClass` varchar(50) NOT NULL COMMENT '操作表表名',
  `propertyName` varchar(50) NOT NULL COMMENT '操作表属性名',
  `propertyValue` varchar(50) NOT NULL COMMENT '操作表属性值',
  `operationType` char(1) NOT NULL COMMENT '操作表操作类型0add 1update 2delete',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=265 DEFAULT CHARSET=utf8mb4 COMMENT='用户操作记录详情表';

DROP TABLE IF EXISTS `user_sync_data`;
CREATE TABLE `user_sync_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '同步数据表id',
  `syncJson` text NOT NULL COMMENT '同步表的数据(表数据的json格式）',
  `ctime` datetime NOT NULL COMMENT '数据插入时间',
  `syncTime` datetime DEFAULT NULL COMMENT '同步时间',
  `isSync` char(1) NOT NULL DEFAULT '0' COMMENT '是否同步（0：未同步   1：已同步）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户相关数据同步表';


DROP PROCEDURE IF EXISTS `abnormalByUserIdPro`;
CREATE  PROCEDURE `abnormalByUserIdPro`(IN `in_userId` integer,IN `in_currentTime` datetime) 
BEGIN
	DECLARE _count,isworkday,tempstatus,temptype  int( 1 )//
	DECLARE tempInoutTime,tempamstarttime , tempamendtime, temppmstarttime , temppmendtime , tempnightstarttime , tempnightendtime, todaybegin, todayend, currenttime,tempBeginTime,tempEndTime varchar(25)//
 	DECLARE done INT DEFAULT 0//
	DECLARE tempuserId int(11) DEFAULT 0//
	DECLARE cur_1 CURSOR FOR select t.createTime,t.userid from palm_inout t where t.userid = in_userId and t.status=1 and t.createTime > todaybegin and t.createTime <= tempamstarttime//
	DECLARE cur_2 CURSOR FOR select t.createTime,t.userid from palm_inout t where t.userid = in_userId and t.status=1 and t.createTime > tempamstarttime and t.createTime <= tempamendtime//
	DECLARE cur_4 CURSOR FOR select d.userid from palm_user_department d where d.userid = in_userId and not EXISTS( select userid from palm_inout where createTime > todaybegin and createTime <= tempamendtime and userid=d.userid) group by d.userid//
 	DECLARE cur_5 CURSOR FOR select createTime,userid from palm_inout where userid = in_userId and status=2 and createTime > tempamstarttime and createTime <= tempamendtime//
 	DECLARE cur_6 CURSOR FOR select createTime,userid from palm_inout where userid = in_userId and status=2 and createTime > tempamendtime and createTime <= ifnull(temppmstarttime, todayend)//
	DECLARE cur_7 CURSOR FOR select createTime,userid  from palm_inout where userid = in_userId and exists(select userid  from palm_inout where status=2 and createTime>todaybegin and createTime< ifnull(temppmstarttime, todayend) ) and not exists (select userid from palm_inout where status=1 and createTime>todaybegin and createTime<tempamendtime )//
	DECLARE cur_8 CURSOR FOR select createTime,userid  from palm_inout where userid = in_userId and exists(select userid  from palm_inout where status=1 and createTime>todaybegin and createTime< tempamendtime ) and not exists (select userid from palm_inout where status=2 and createTime>todaybegin and createTime< ifnull(temppmstarttime, todayend ) )//
	DECLARE cur_9 CURSOR FOR select t.createTime,t.userid from palm_inout t where t.userid = in_userId and t.status=1 and t.createTime >  ifnull(tempamendtime, todaybegin) and t.createTime <= temppmstarttime//
	DECLARE cur_10 CURSOR FOR select t.createTime,t.userid from palm_inout t where t.userid = in_userId and t.status=1 and t.createTime > temppmstarttime and t.createTime <= temppmendtime//
 	DECLARE cur_11 CURSOR FOR select createTime,userid from palm_inout where userid = in_userId and status=2 and createTime > temppmstarttime and createTime <= temppmendtime//
	DECLARE cur_13 CURSOR FOR select distinct d.userid from palm_user_department d where d.userid = in_userId  and not EXISTS( select userid from palm_inout where createTime > ifnull(tempamendtime, todaybegin )  and createTime <= temppmendtime and userid=d.userid ) group by d.userid//
 	DECLARE cur_14 CURSOR FOR select createTime,userid from palm_inout where userid = in_userId and status=2 and createTime > temppmendtime and createTime <= ifnull( tempnightstarttime, todayend)//
	DECLARE cur_15 CURSOR FOR select createTime,userid  from palm_inout where userid = in_userId and exists(select userid  from palm_inout where status=2 and createTime>   ifnull(tempamendtime, todaybegin) and createTime< ifnull( tempnightstarttime, todayend) ) and not exists (select userid from palm_inout where status=1 and createTime> ifnull(tempamendtime, todaybegin) and createTime<temppmendtime )//
	DECLARE cur_16 CURSOR FOR select createTime,userid  from palm_inout where userid = in_userId and exists(select userid  from palm_inout where status=1 and createTime> ifnull(tempamendtime, todaybegin) and createTime< temppmendtime ) and not exists (select userid from palm_inout where status=2 and createTime>temppmstarttime and createTime< ifnull( tempnightstarttime, todayend ) )//
	DECLARE cur_17 CURSOR FOR select t.createTime,t.userid from palm_inout t where t.userid = in_userId and t.status=1 and t.createTime > todaybegin and t.createTime <= tempBeginTime//
	DECLARE cur_18 CURSOR FOR select t.createTime,t.userid from palm_inout t where t.userid = in_userId and t.status=1 and t.createTime > tempBeginTime and t.createTime <= tempEndTime//
	DECLARE cur_19 CURSOR FOR select t.createTime,t.userid from palm_inout t where t.userid = in_userId and t.status=2 and t.createTime > tempBeginTime and t.createTime <= tempEndTime//
	DECLARE cur_20 CURSOR FOR select t.createTime,t.userid from palm_inout t where t.userid = in_userId and t.status=2 and t.createTime > tempEndTime and t.createTime <= todayend//
	DECLARE cur_22 CURSOR FOR select d.userid from palm_user_department d where d.userid = in_userId  and not EXISTS( select userid from palm_inout where createTime > todaybegin and createTime <= tempEndTime and userid=d.userid ) group by d.userid//
	DECLARE cur_23 CURSOR FOR select createTime,userid  from palm_inout where userid = in_userId and exists(select userid  from palm_inout where status=2 and createTime>todaybegin and createTime< ifnull(tempEndTime, todayend) ) and not exists (select userid from palm_inout where status=1 and createTime>todaybegin and createTime<tempEndTime )//
	DECLARE cur_24 CURSOR FOR select createTime,userid  from palm_inout where userid = in_userId and exists(select userid  from palm_inout where status=1 and createTime>todaybegin and createTime< tempEndTime ) and not exists (select userid from palm_inout where status=2 and createTime>todaybegin and createTime< ifnull( tempEndTime, todayend ) )//
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1//
	select count(*) into _count from palm_schedule_teacher where liveingDate = CURRENT_DATE() and teacherId = in_userId limit 1//
	if _count > 0 then
			select status, concat(amstarttime,':00'), concat(amendtime,':00'), concat(pmstarttime,':00'), concat(pmendtime,':00'), concat(nightstarttime,':00'),  concat(nightendtime,':00'),concat(beginTime,':00'),concat(endTime,':00'),type  into isworkday, tempamstarttime, tempamendtime, temppmstarttime, temppmendtime, tempnightstarttime,  tempnightendtime,tempBeginTime,tempEndTime,temptype from palm_schedule_teacher where liveingDate = CURRENT_DATE() and teacherId = in_userId limit 1// 
	else 
			select status, concat(amstarttime,':00'), concat(amendtime,':00'), concat(pmstarttime,':00'), concat(pmendtime,':00'), concat(nightstarttime,':00'),  concat(nightendtime,':00'),concat(beginTime,':00'),concat(endTime,':00'),type  into isworkday, tempamstarttime, tempamendtime, temppmstarttime, temppmendtime, tempnightstarttime,  tempnightendtime,tempBeginTime,tempEndTime,temptype from palm_scheduledetail where liveingDate = CURRENT_DATE() limit 1// 			
	end if//
	select concat(CURRENT_DATE() ,' 00:00:01')into todaybegin//
	select concat(CURRENT_DATE() ,' 23:59:59')into todayend//
	set currenttime = in_currentTime//
	
	if isworkday = 0 then
		if temptype = 0 then		
		if tempamstarttime is not null then
			
			if ( currenttime > tempamstarttime && currenttime <= tempamendtime )  then 
				select status into tempstatus from palm_checkattendance_order where id=5//
				if tempstatus=0 then
				 open cur_1//
 				 REPEAT
 				 FETCH cur_1 INTO tempInoutTime,tempuserId//
 				 if not done then
						insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime) ( select ud.userId,ud.departmentId, null, 5, 0, CURRENT_DATE(), NOW() ,tempInoutTime from palm_user_department ud, palm_department d where ud.departmentId=d.id and d.isAttendance='0' and userId = tempuserId  and NOT EXISTS(select userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=5 and type=0 and userid=tempuserId )  group by userid )//
					end if//
 				UNTIL done END REPEAT//
 				CLOSE cur_1//
				set done = 0//
				end if//
				select status into tempstatus from palm_checkattendance_order where id=2//
				if tempstatus=0 then			
				open cur_2//
 				REPEAT
 				 FETCH cur_2 INTO tempInoutTime,tempuserId//				
 				 if not done then
					if not exists(select userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=5 and userid=tempuserId )  then					
						insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select ud.userId,ud.departmentId, null, 2, 0, CURRENT_DATE(), NOW() ,tempInoutTime from palm_user_department ud, palm_department d where ud.departmentId=d.id and d.isAttendance='0' and userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status in(5,2 ) and type=0 and userid=tempuserId )  group by userid)//
					end if//
				end if// 
 				UNTIL done END REPEAT//
 				CLOSE cur_2//
				set done = 0//
				end if//
				
				select status into tempstatus from palm_checkattendance_order where id=3//
				if tempstatus=0 then				
				open cur_5//
 				REPEAT
 				 FETCH cur_5 INTO tempInoutTime,tempuserId//
 				 if not done then 
  					insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select ud.userId,ud.departmentId, null, 3, 0, CURRENT_DATE(), NOW() ,tempInoutTime from palm_user_department ud, palm_department d where ud.departmentId=d.id and d.isAttendance='0' and userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=3  and type=0 and userid=tempuserId ) group by userid )//
  				end if// 
 				UNTIL done END REPEAT//
 				CLOSE cur_5//
				set done = 0//
				end if//				
			end if//
			if (currenttime >=tempamendtime &&  currenttime<= ifnull(temppmstarttime, todayend ))  then
				select status into tempstatus from palm_checkattendance_order where id=1//
				if tempstatus=0 then				
				open cur_4//
 				REPEAT
 				 FETCH cur_4 INTO tempuserId//
 				 if not done then
  					insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime)  (select ud.userId,ud.departmentId, null, 1, 0, CURRENT_DATE(), NOW()  from palm_user_department ud, palm_department d where ud.departmentId=d.id and d.isAttendance='0' and userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =1  and type=0 and userid=tempuserId ) group by userid )//
  				end if// 
 				UNTIL done END REPEAT//
 				CLOSE cur_4//
				set done = 0//
				end if//				
			end if//
			if  currenttime >= ifnull(temppmstarttime, todayend )  then
				select status into tempstatus from palm_checkattendance_order where id=4//
				if tempstatus=0 then				
				open cur_6//
 				REPEAT
 				 FETCH cur_6 INTO tempInoutTime,tempuserId//
 				 if not done then
					if exists(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =1  and userid=tempuserId) then
					  delete from palm_checkattendance where createDate=CURRENT_DATE() and  status =1  and userid=tempuserId//
					end if//
					if exists(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =3   and userid=tempuserId) then
						delete from palm_checkattendance where createDate=CURRENT_DATE() and  status =3   and userid=tempuserId//
					end if//
  					insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select ud.userId,ud.departmentId, null, 4, 0, CURRENT_DATE(), NOW() ,tempInoutTime from palm_user_department ud, palm_department d where ud.departmentId=d.id and d.isAttendance='0' and userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=4  and type=0 and userid=tempuserId )  group by userid)//
					
  				end if// 
 				UNTIL done END REPEAT//
 				CLOSE cur_6//
				set done = 0//
				end if//
				select status into tempstatus from palm_checkattendance_order where id=7//
				if tempstatus=0 then				
				open cur_8//
 				REPEAT
 				 FETCH cur_8 INTO tempInoutTime,tempuserId//
 				 if not done then
					if exists(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =1  and userid=tempuserId) then
					  delete from palm_checkattendance where createDate=CURRENT_DATE() and  status =1  and userid=tempuserId//
					end if//
  					insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select ud.userId,ud.departmentId, null, 7, 0, CURRENT_DATE(), NOW(),tempInoutTime  from palm_user_department ud, palm_department d where ud.departmentId=d.id and d.isAttendance='0' and userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=7  and type=0 and userid=tempuserId ) group by userid )//
					
  				end if// 
 				UNTIL done END REPEAT//
 				CLOSE cur_8//
				set done = 0//
				end if//
				select status into tempstatus from palm_checkattendance_order where id=6//
				if tempstatus=0 then				
				open cur_7//
 				REPEAT
 				 FETCH cur_7 INTO tempInoutTime,tempuserId//
 				 if not done then
					if exists(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =1  and userid=tempuserId) then
					  delete from palm_checkattendance where createDate=CURRENT_DATE() and  status =1  and userid=tempuserId//
					end if//
  					insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select ud.userId,ud.departmentId, null,6, 0, CURRENT_DATE(), NOW(),tempInoutTime  from palm_user_department ud, palm_department d where ud.departmentId=d.id and d.isAttendance='0' and userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=6  and type=0 and userid=tempuserId ) group by userid )//
					
  				end if// 
 				UNTIL done END REPEAT//
 				CLOSE cur_7//
				set done = 0//
				end if//
			end if//
		end if//
		if temppmstarttime is not null then
			
			if (currenttime >= temppmstarttime && currenttime <= temppmendtime )  then 
				select status into tempstatus from palm_checkattendance_order where id=11//
				if tempstatus=0 then
				 open cur_9//
 				 REPEAT
 				 FETCH cur_9 INTO tempInoutTime,tempuserId//
 				 if not done then
					insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime) ( select ud.userId,ud.departmentId, null, 11, 0, CURRENT_DATE(), NOW(),tempInoutTime  from palm_user_department ud, palm_department d where ud.departmentId=d.id and d.isAttendance='0' and userId = tempuserId  and NOT EXISTS(select userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=11 and type=0 and userid=tempuserId )  group by userid )//
  				end if//
 				UNTIL done END REPEAT//
 				CLOSE cur_9//
				set done = 0//
				end if//
				select status into tempstatus from palm_checkattendance_order where id=9//
				if tempstatus=0 then
				open cur_10//
 				REPEAT
 				 FETCH cur_10 INTO tempInoutTime,tempuserId//
 				 if not done then
					if not exists(select userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=11 and userid=tempuserId ) then
						insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select ud.userId,ud.departmentId, null, 9, 0, CURRENT_DATE(), NOW(),tempInoutTime  from palm_user_department ud, palm_department d where ud.departmentId=d.id and d.isAttendance='0' and userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status in(11,9 ) and type=0 and userid=tempuserId ) group by userid )//
					end if//
  				end if// 
 				UNTIL done END REPEAT//
 				CLOSE cur_10//
				set done = 0//
				end if//
				
				select status into tempstatus from palm_checkattendance_order where id=10//
				if tempstatus=0 then				
				open cur_11//
 				REPEAT
 				 FETCH cur_11 INTO tempInoutTime,tempuserId//
 				 if not done then
  					insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select ud.userId,ud.departmentId, null, 10, 0, CURRENT_DATE(), NOW(),tempInoutTime  from palm_user_department ud, palm_department d where ud.departmentId=d.id and d.isAttendance='0' and userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=10  and type=0 and userid=tempuserId ) group by userid)//
					
  				end if// 
 				UNTIL done END REPEAT//
 				CLOSE cur_11//
				set done = 0//
				end if//
		
			end if//
			if (currenttime >=temppmendtime &&  currenttime<= ifnull( tempnightstarttime, todayend ))  then
				select status into tempstatus from palm_checkattendance_order where id=8//
				if tempstatus=0 then				
				open cur_13//
 				REPEAT
 				 FETCH cur_13 INTO tempuserId//
 				 if not done then
  					insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime)  (select ud.userId,ud.departmentId, null, 8, 0, CURRENT_DATE(), NOW()  from palm_user_department ud, palm_department d where ud.departmentId=d.id and d.isAttendance='0' and userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =8  and type=0 and userid=tempuserId )  group by userid)//
					
  				end if// 
 				UNTIL done END REPEAT//
 				CLOSE cur_13//
				set done = 0//
				end if//
			end if//
			if (currenttime>= ifnull( tempnightstarttime, todayend )) then
				select status into tempstatus from palm_checkattendance_order where id=12//
				if tempstatus=0 then				
				open cur_14//
 				REPEAT
 				 FETCH cur_14 INTO tempInoutTime,tempuserId//
 				 if not done then
					if exists(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =8  and userid=tempuserId) then
					  delete from palm_checkattendance where createDate=CURRENT_DATE() and  status =8  and userid=tempuserId//
					end if//
					if exists(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=10   and userid=tempuserId) then
						delete from  palm_checkattendance where createDate=CURRENT_DATE() and  status=10   and userid=tempuserId//
					end if//
  					insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select ud.userId,ud.departmentId, null, 12, 0, CURRENT_DATE(), NOW(),tempInoutTime  from palm_user_department ud, palm_department d where ud.departmentId=d.id and d.isAttendance='0' and userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=12  and type=0 and userid=tempuserId )  group by userid)//
					
  				end if// 
 				UNTIL done END REPEAT//
 				CLOSE cur_14//
				set done = 0//
				end if//
				select status into tempstatus from palm_checkattendance_order where id=13//
				if tempstatus=0 then				
				open cur_15//
 				REPEAT
 				 FETCH cur_15 INTO tempInoutTime,tempuserId//
 				 if not done then
					if exists(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =8  and userid=tempuserId) then
					  delete from palm_checkattendance where createDate=CURRENT_DATE() and  status =8  and userid=tempuserId//
					end if//
  					insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select ud.userId,ud.departmentId, null, 13, 0, CURRENT_DATE(), NOW(),tempInoutTime  from palm_user_department ud, palm_department d where ud.departmentId=d.id and d.isAttendance='0' and userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=13  and type=0 and userid=tempuserId ) group by userid )//
					
  				end if// 
 				UNTIL done END REPEAT//
 				CLOSE cur_15//
				set done = 0//
				end if//
				select status into tempstatus from palm_checkattendance_order where id=14//
				if tempstatus=0 then				
				open cur_16//
 				REPEAT
 				 FETCH cur_16 INTO tempInoutTime,tempuserId//
 				 if not done then
					if exists(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =8  and userid=tempuserId) then
					  delete from palm_checkattendance where createDate=CURRENT_DATE() and  status =8  and userid=tempuserId//
					end if//
  					insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select ud.userId,ud.departmentId, null, 14, 0, CURRENT_DATE(), NOW(),tempInoutTime  from palm_user_department ud, palm_department d where ud.departmentId=d.id and d.isAttendance='0' and userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=14  and type=0 and userid=tempuserId ) group by userid )//
					
  				end if// 
 				UNTIL done END REPEAT//
 				CLOSE cur_16//
				set done = 0//
				end if//
			end if//
		end if//
		end if//
		if temptype = 1 then
			if tempBeginTime is not null then
				if ( currenttime > tempBeginTime &&  currenttime < tempEndTime) then
					select status into tempstatus from palm_checkattendance_order where id=22//
					if tempstatus=0 then
				 		open cur_17//
 						 REPEAT
 						 FETCH cur_17 INTO tempInoutTime,tempuserId//
 				 		if not done then
							insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime) ( select ud.userId,ud.departmentId, null, 22, 0, CURRENT_DATE(), NOW(),tempInoutTime  from palm_user_department ud, palm_department d where ud.departmentId=d.id and d.isAttendance='0' and userId = tempuserId  and NOT EXISTS(select userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=22 and type=0 and userid=tempuserId )  group by userid )//
  						end if//
 						UNTIL done END REPEAT//
 						CLOSE cur_17//
						set done = 0//
					end if//
					select status into tempstatus from palm_checkattendance_order where id=23//
					if tempstatus=0 then			
					open cur_18//
 					REPEAT
 					 FETCH cur_18 INTO tempInoutTime,tempuserId//				
 					 if not done then
						if not exists(select userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=22 and userid=tempuserId )  then					
							insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select ud.userId,ud.departmentId, null, 23, 0, CURRENT_DATE(), NOW(),tempInoutTime  from palm_user_department ud, palm_department d where ud.departmentId=d.id and d.isAttendance='0' and userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status in(21,23) and type=0 and userid=tempuserId )  group by userid)//
  						end if//
					end if// 
 					UNTIL done END REPEAT//
 					CLOSE cur_18//
					set done = 0//
					end if//
				
					select status into tempstatus from palm_checkattendance_order where id=24//
					if tempstatus=0 then				
					open cur_19//
 					REPEAT
 					 FETCH cur_19 INTO tempInoutTime,tempuserId//
 					 if not done then
  						insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select ud.userId,ud.departmentId, null, 24, 0, CURRENT_DATE(), NOW(),tempInoutTime  from palm_user_department ud, palm_department d where ud.departmentId=d.id and d.isAttendance='0' and userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=24  and type=0 and userid=tempuserId ) group by userid )//
					
  					end if// 
 					UNTIL done END REPEAT//
 					CLOSE cur_19//
					set done = 0//
					end if//	
				end if//
				if ( currenttime > tempEndTime) then
					select status into tempstatus from palm_checkattendance_order where id=25//
					if tempstatus=0 then				
					open cur_20//
 					REPEAT
 					 FETCH cur_20 INTO tempInoutTime,tempuserId//
 					 if not done then
						if exists(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =26  and userid=tempuserId) then
					  		delete from palm_checkattendance where createDate=CURRENT_DATE() and  status =26  and userid=tempuserId//
						end if//
						if exists(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=24   and userid=tempuserId) then
							delete from  palm_checkattendance where createDate=CURRENT_DATE() and  status=24   and userid=tempuserId//
						end if//
  						insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select ud.userId,ud.departmentId, null, 25, 0, CURRENT_DATE(), NOW(),tempInoutTime  from palm_user_department ud, palm_department d where ud.departmentId=d.id and d.isAttendance='0' and userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=25  and type=0 and userid=tempuserId )  group by userid)//
					
  					end if// 
 					UNTIL done END REPEAT//
 					CLOSE cur_20//
					set done = 0//
					end if//
					select status into tempstatus from palm_checkattendance_order where id=26//
					if tempstatus=0 then				
					open cur_22//
 					REPEAT
 					 FETCH cur_22 INTO tempuserId//
 					 if not done then
  						insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime)  (select ud.userId,ud.departmentId, null, 26, 0, CURRENT_DATE(), NOW()  from palm_user_department ud, palm_department d where ud.departmentId=d.id and d.isAttendance='0' and userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =26  and type=0 and userid=tempuserId )  group by userid)//
					
  					end if// 
 					UNTIL done END REPEAT//
 					CLOSE cur_22//
					set done = 0//
					end if//
					select status into tempstatus from palm_checkattendance_order where id=27//
					if tempstatus=0 then				
					open cur_23//
 					REPEAT
 				 	FETCH cur_23 INTO tempInoutTime,tempuserId//
 				 	if not done then
						if exists(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =26  and userid=tempuserId) then
					 	 delete from palm_checkattendance where createDate=CURRENT_DATE() and  status =26  and userid=tempuserId//
						end if//
  						insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select ud.userId,ud.departmentId, null, 27, 0, CURRENT_DATE(), NOW(),tempInoutTime  from palm_user_department ud, palm_department d where ud.departmentId=d.id and d.isAttendance='0' and userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=27  and type=0 and userid=tempuserId ) group by userid )//
					
  					end if// 
 					UNTIL done END REPEAT//
 					CLOSE cur_23//
					set done = 0//
					end if//
					select status into tempstatus from palm_checkattendance_order where id=28//
					if tempstatus=0 then				
					open cur_24//
 					REPEAT
 				 	FETCH cur_24 INTO tempInoutTime,tempuserId//
 				 	if not done then
						if exists(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =26  and userid=tempuserId) then
					 	 delete from palm_checkattendance where createDate=CURRENT_DATE() and  status =26  and userid=tempuserId//
						end if//
  						insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select ud.userId,ud.departmentId, null, 28, 0, CURRENT_DATE(), NOW(),tempInoutTime  from palm_user_department ud, palm_department d where ud.departmentId=d.id and d.isAttendance='0' and userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=28  and type=0 and userid=tempuserId ) group by userid )//
					
  					end if// 
 					UNTIL done END REPEAT//
 					CLOSE cur_24//
					set done = 0//
					end if//
				end if//
			end if//
		end if//
	end if//
END;

DROP PROCEDURE IF EXISTS `abnomalByclazzIdPro`;
CREATE  PROCEDURE `abnomalByclazzIdPro`(IN `in_clazzId` INTEGER,IN `in_currentTime` DATETIME)
BEGIN
	DECLARE _count,isworkday,tempstatus,temptype  int( 1 )//
	DECLARE tempInoutTime,tempamstarttime , tempamendtime, temppmstarttime , temppmendtime , tempnightstarttime , tempnightendtime, todaybegin, todayend, currenttime,tempBeginTime,tempEndTime varchar(25)//
 	DECLARE done INT DEFAULT 0//
	DECLARE tempuserId int(11) DEFAULT 0//
	DECLARE cur_1 CURSOR FOR select t.createTime,t.userid from palm_inout t,palm_student_clazz c where t.userId = c.userId and c.clazzId = in_clazzId and t.status=1 and t.createTime > todaybegin and t.createTime <= tempamstarttime//
	DECLARE cur_2 CURSOR FOR select t.createTime,t.userid from palm_inout t,palm_student_clazz c where t.userId = c.userId and c.clazzId = in_clazzId and t.status=1 and t.createTime > tempamstarttime and t.createTime <= tempamendtime//
	DECLARE cur_3 CURSOR FOR select c.userid from palm_student_clazz c where c.clazzId = in_clazzId and not EXISTS( select userid from palm_inout where createTime > todaybegin and createTime <= tempamendtime and userid=c.userid )//
 	DECLARE cur_5 CURSOR FOR select t.createTime,t.userid from palm_inout t,palm_student_clazz c where t.userId = c.userId and c.clazzId = in_clazzId and t.status=2 and t.createTime > tempamstarttime and t.createTime <= tempamendtime//
 	DECLARE cur_6 CURSOR FOR select t.createTime,t.userid from palm_inout t,palm_student_clazz c where t.userId = c.userId and c.clazzId = in_clazzId and  t.status=2 and t.createTime > tempamendtime and t.createTime <= ifnull(temppmstarttime, todayend)//
	DECLARE cur_7 CURSOR FOR select t.createTime,t.userid  from palm_inout t,palm_student_clazz c where t.userId = c.userId and c.clazzId = in_clazzId and exists(select userid  from palm_inout where status=2 and createTime>todaybegin and createTime< ifnull(temppmstarttime, todayend) ) and not exists (select userid from palm_inout where status=1 and createTime>todaybegin and createTime<tempamendtime )//
	DECLARE cur_8 CURSOR FOR select t.createTime,t.userid  from palm_inout t,palm_student_clazz c where t.userId = c.userId and c.clazzId = in_clazzId and exists(select userid  from palm_inout where status=1 and createTime>todaybegin and createTime< tempamendtime ) and not exists (select userid from palm_inout where status=2 and createTime>todaybegin and createTime< ifnull(temppmstarttime, todayend ) )//
	DECLARE cur_9 CURSOR FOR select t.createTime,t.userid from palm_inout t,palm_student_clazz c where  t.userId = c.userId and c.clazzId = in_clazzId and t.status=1 and t.createTime >  ifnull(tempamendtime, todaybegin) and t.createTime <= temppmstarttime//
	DECLARE cur_10 CURSOR FOR select t.createTime,t.userid from palm_inout t,palm_student_clazz c where t.userId = c.userId and c.clazzId = in_clazzId and t.status=1 and t.createTime > temppmstarttime and t.createTime <= temppmendtime//
 	DECLARE cur_11 CURSOR FOR select t.createTime,t.userid from palm_inout t,palm_student_clazz c where  t.userId = c.userId and c.clazzId = in_clazzId and t.status=2 and t.createTime > temppmstarttime and t.createTime <= temppmendtime//
	DECLARE cur_12 CURSOR FOR select c.userid from palm_student_clazz c where c.clazzId = in_clazzId and not EXISTS( select userid from palm_inout where createTime >  ifnull(tempamendtime, todaybegin ) and createTime <= temppmendtime and userid=c.userid ) //
 	DECLARE cur_14 CURSOR FOR select t.createTime,t.userid from palm_inout t,palm_student_clazz c where t.userId = c.userId and c.clazzId = in_clazzId and t.status=2 and t.createTime > temppmendtime and t.createTime <= ifnull( tempnightstarttime, todayend)//
	DECLARE cur_15 CURSOR FOR select t.createTime,t.userid  from palm_inout t,palm_student_clazz c where t.userId = c.userId and c.clazzId = in_clazzId and exists(select userid  from palm_inout where status=2 and createTime>   ifnull(tempamendtime, todaybegin) and createTime< ifnull( tempnightstarttime, todayend) ) and not exists (select userid from palm_inout where status=1 and createTime> ifnull(tempamendtime, todaybegin) and createTime<temppmendtime )//
	DECLARE cur_16 CURSOR FOR select t.createTime,t.userid  from palm_inout t,palm_student_clazz c where t.userId = c.userId and c.clazzId = in_clazzId and exists(select userid  from palm_inout where status=1 and createTime> ifnull(tempamendtime, todaybegin) and createTime< temppmendtime ) and not exists (select userid from palm_inout where status=2 and createTime>temppmstarttime and createTime< ifnull( tempnightstarttime, todayend ) )//
	DECLARE cur_17 CURSOR FOR select t.createTime,t.userid from palm_inout t,palm_student_clazz c where t.userId = c.userId and c.clazzId = in_clazzId and t.status=1 and t.createTime > todaybegin and t.createTime <= tempBeginTime//
	DECLARE cur_18 CURSOR FOR select t.createTime,t.userid from palm_inout t,palm_student_clazz c where t.userId = c.userId and c.clazzId = in_clazzId and t.status=1 and t.createTime > tempBeginTime and t.createTime <= tempEndTime//
	DECLARE cur_19 CURSOR FOR select t.createTime,t.userid from palm_inout t,palm_student_clazz c where t.userId = c.userId and c.clazzId = in_clazzId and t.status=2 and t.createTime > tempBeginTime and t.createTime <= tempEndTime//
	DECLARE cur_20 CURSOR FOR select t.createTime,t.userid from palm_inout t,palm_student_clazz c where t.userId = c.userId and c.clazzId = in_clazzId and t.status=2 and t.createTime > tempEndTime and t.createTime <= todayend//
	DECLARE cur_21 CURSOR FOR select c.userid from palm_student_clazz c where c.clazzId = in_clazzId and not EXISTS( select userid from palm_inout where createTime > todaybegin and createTime <= tempEndTime and userid=c.userid )//
	DECLARE cur_23 CURSOR FOR select t.createTime,t.userid  from palm_inout t,palm_student_clazz c where t.userId = c.userId and c.clazzId = in_clazzId and exists(select userid  from palm_inout where status=2 and createTime>todaybegin and createTime< ifnull(tempEndTime, todayend) ) and not exists (select userid from palm_inout where status=1 and createTime>todaybegin and createTime<tempEndTime )//
	DECLARE cur_24 CURSOR FOR select t.createTime,t.userid  from palm_inout t,palm_student_clazz c where t.userId = c.userId and c.clazzId = in_clazzId and exists(select userid  from palm_inout where status=1 and createTime>todaybegin and createTime< tempEndTime ) and not exists (select userid from palm_inout where status=2 and createTime>todaybegin and createTime< ifnull( tempEndTime, todayend ) )//
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1//
	select count(*) into _count from palm_schedule_clazz where liveingDate = CURRENT_DATE() and clazzId = in_clazzId limit 1// 
	if _count > 0 then
			select status, amstarttime, amendtime, pmstarttime, pmendtime, nightstarttime,  nightendtime,beginTime,endTime,type  into isworkday, tempamstarttime, tempamendtime, temppmstarttime, temppmendtime, tempnightstarttime,  tempnightendtime,tempBeginTime,tempEndTime,temptype from palm_schedule_clazz where liveingDate = CURRENT_DATE() and clazzId = in_clazzId limit 1// 
	else 
			select status, amstarttime, amendtime, pmstarttime, pmendtime, nightstarttime,  nightendtime,beginTime,endTime,type  into isworkday, tempamstarttime, tempamendtime, temppmstarttime, temppmendtime, tempnightstarttime,  tempnightendtime,tempBeginTime,tempEndTime,temptype from palm_scheduledetail where liveingDate = CURRENT_DATE() limit 1// 			
	end if//

	select concat(CURRENT_DATE() ,' 00:00:01')into todaybegin//
	select concat(CURRENT_DATE() ,' 23:59:59')into todayend//
	set currenttime = in_currentTime//
	
	if isworkday = 0 then
		if temptype = 0 then		
		if tempamstarttime is not null then
			
			if ( currenttime > tempamstarttime && currenttime <= tempamendtime )  then 
				select status into tempstatus from palm_checkattendance_order where id=5//
				if tempstatus=0 then
				 open cur_1//
 				 REPEAT
 				 FETCH cur_1 INTO tempInoutTime,tempuserId//
 				 if not done then
  					insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select userId,null, clazzId, 5, 1, CURRENT_DATE(), NOW() ,tempInoutTime from palm_student_clazz where userId = tempuserId and NOT EXISTS (select userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=5 and type=1 and userid=tempuserId ))// 
					end if//
 				UNTIL done END REPEAT//
 				CLOSE cur_1//
				set done = 0//
				end if//
				select status into tempstatus from palm_checkattendance_order where id=2//
				if tempstatus=0 then			
				open cur_2//
 				REPEAT
 				 FETCH cur_2 INTO tempInoutTime,tempuserId//				
 				 if not done then
					if not exists(select userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=5 and userid=tempuserId )  then					
  					insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select userId,null, clazzId, 2, 1, CURRENT_DATE(), NOW(),tempInoutTime  from palm_student_clazz where userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status in(5,2 ) and type=1 and userid=tempuserId ) )//
					end if//
				end if// 
 				UNTIL done END REPEAT//
 				CLOSE cur_2//
				set done = 0//
				end if//
				
				select status into tempstatus from palm_checkattendance_order where id=3//
				if tempstatus=0 then				
				open cur_5//
 				REPEAT
 				 FETCH cur_5 INTO tempInoutTime,tempuserId//
 				 if not done then
  					insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select userId,null, clazzId, 3, 1, CURRENT_DATE(), NOW(),tempInoutTime   from palm_student_clazz where userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =3  and type=1 and userid=tempuserId ) )//
  				end if// 
 				UNTIL done END REPEAT//
 				CLOSE cur_5//
				set done = 0//
				end if//				
			end if//
			if (currenttime >=tempamendtime &&  currenttime<= ifnull(temppmstarttime, todayend ))  then
				select status into tempstatus from palm_checkattendance_order where id=1//
				if tempstatus=0 then		
				open cur_3//
 				REPEAT
 				 FETCH cur_3 INTO tempuserId//
 				 if not done then
  					insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime)  (select userId,null, clazzId, 1, 1, CURRENT_DATE(), NOW()  from palm_student_clazz where userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=1  and type=1 and userid=tempuserId ) )//
					
  				end if// 
 				UNTIL done END REPEAT//
 				CLOSE cur_3//
				set done = 0//
				end if//				
			end if//
			if  currenttime >= ifnull(temppmstarttime, todayend )  then
				select status into tempstatus from palm_checkattendance_order where id=4//
				if tempstatus=0 then				
				open cur_6//
 				REPEAT
 				 FETCH cur_6 INTO tempInoutTime,tempuserId//
 				 if not done then
					if exists(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =1  and userid=tempuserId) then
					  delete from palm_checkattendance where createDate=CURRENT_DATE() and  status =1  and userid=tempuserId//
					end if//
					if exists(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =3   and userid=tempuserId) then
						delete from palm_checkattendance where createDate=CURRENT_DATE() and  status =3   and userid=tempuserId//
					end if//
  					insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select userId,null, clazzId, 4, 1, CURRENT_DATE(), NOW(),tempInoutTime  from palm_student_clazz where userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =4  and type=1 and userid=tempuserId ) )//
					
  				end if// 
 				UNTIL done END REPEAT//
 				CLOSE cur_6//
				set done = 0//
				end if//
				select status into tempstatus from palm_checkattendance_order where id=7//
				if tempstatus=0 then				
				open cur_8//
 				REPEAT
 				 FETCH cur_8 INTO tempInoutTime,tempuserId//
 				 if not done then
					if exists(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =1  and userid=tempuserId) then
					  delete from palm_checkattendance where createDate=CURRENT_DATE() and  status =1  and userid=tempuserId//
					end if//
  					insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select userId,null, clazzId, 7, 1, CURRENT_DATE(), NOW(),tempInoutTime  from palm_student_clazz where userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =7  and type=1 and userid=tempuserId ) )//
					
  				end if// 
 				UNTIL done END REPEAT//
 				CLOSE cur_8//
				set done = 0//
				end if//
				select status into tempstatus from palm_checkattendance_order where id=6//
				if tempstatus=0 then				
				open cur_7//
 				REPEAT
 				 FETCH cur_7 INTO tempInoutTime,tempuserId//
 				 if not done then
					if exists(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =1  and userid=tempuserId) then
					  delete from palm_checkattendance where createDate=CURRENT_DATE() and  status =1  and userid=tempuserId//
					end if//
  					insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select userId,null, clazzId, 6, 1, CURRENT_DATE(), NOW(),tempInoutTime  from palm_student_clazz where userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =6  and type=1 and userid=tempuserId ) )//
					
  				end if// 
 				UNTIL done END REPEAT//
 				CLOSE cur_7//
				set done = 0//
				end if//
			end if//
		end if//
		if temppmstarttime is not null then
			
			if (currenttime >= temppmstarttime && currenttime <= temppmendtime )  then 
				select status into tempstatus from palm_checkattendance_order where id=11//
				if tempstatus=0 then
				 open cur_9//
 				 REPEAT
 				 FETCH cur_9 INTO tempInoutTime,tempuserId//
 				 if not done then
  					insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select userId,null, clazzId, 11, 1, CURRENT_DATE(), NOW(),tempInoutTime  from palm_student_clazz where userId = tempuserId and NOT EXISTS (select userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=11 and type=1 and userid=tempuserId ))// 
  				end if//
 				UNTIL done END REPEAT//
 				CLOSE cur_9//
				set done = 0//
				end if//
				select status into tempstatus from palm_checkattendance_order where id=9//
				if tempstatus=0 then
				open cur_10//
 				REPEAT
 				 FETCH cur_10 INTO tempInoutTime,tempuserId//
 				 if not done then 
					if not exists(select userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=11 and userid=tempuserId ) then 
  						insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select userId,null, clazzId, 9, 1, CURRENT_DATE(), NOW(),tempInoutTime  from palm_student_clazz where userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status in(11,9 ) and type=1 and userid=tempuserId ) )//
					end if//
  				end if// 
 				UNTIL done END REPEAT//
 				CLOSE cur_10//
				set done = 0//
				end if//
				
				select status into tempstatus from palm_checkattendance_order where id=10//
				if tempstatus=0 then				
				open cur_11//
 				REPEAT
 				 FETCH cur_11 INTO tempInoutTime,tempuserId//
 				 if not done then
  					insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select userId,null, clazzId, 10, 1, CURRENT_DATE(), NOW(),tempInoutTime  from palm_student_clazz where userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =10  and type=1 and userid=tempuserId ) )//
					
  				end if// 
 				UNTIL done END REPEAT//
 				CLOSE cur_11//
				set done = 0//
				end if//
		
			end if//
			if (currenttime >=temppmendtime &&  currenttime<= ifnull( tempnightstarttime, todayend ))  then
				select status into tempstatus from palm_checkattendance_order where id=8//
				if tempstatus=0 then				
				open cur_12//
 				REPEAT
 				 FETCH cur_12 INTO tempuserId//
 				 if not done then
  					insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime)  (select userId,null, clazzId, 8, 1, CURRENT_DATE(), NOW()  from palm_student_clazz where userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=8  and type=1 and userid=tempuserId ) )//
					
  				end if// 
 				UNTIL done END REPEAT//
 				CLOSE cur_12//
				set done = 0//
				end if//
			end if//
			IF (currenttime >=temppmendtime &&  currenttime<= ifnull( tempnightstarttime, todayend )) then
				select status into tempstatus from palm_checkattendance_order where id=12//
				if tempstatus=0 then				
				open cur_14//
 				REPEAT
 				 FETCH cur_14 INTO tempInoutTime,tempuserId//
 				 if not done then
					if exists(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =8  and userid=tempuserId) then
					  delete from palm_checkattendance where createDate=CURRENT_DATE() and  status =8  and userid=tempuserId//
					end if//
					if exists(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=10   and userid=tempuserId) then
						delete from  palm_checkattendance where createDate=CURRENT_DATE() and  status=10   and userid=tempuserId//
					end if//
  					insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select userId,null, clazzId, 12, 1, CURRENT_DATE(), NOW(),tempInoutTime  from palm_student_clazz where userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =12  and type=1 and userid=tempuserId ) )//
					
  				end if// 
 				UNTIL done END REPEAT//
 				CLOSE cur_14//
				set done = 0//
				end if//
				select status into tempstatus from palm_checkattendance_order where id=13//
				if tempstatus=0 then				
				open cur_15//
 				REPEAT
 				 FETCH cur_15 INTO tempInoutTime,tempuserId//
 				 if not done then
					if exists(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =8  and userid=tempuserId) then
					  delete from palm_checkattendance where createDate=CURRENT_DATE() and  status =8  and userid=tempuserId//
					end if//
  					insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select userId,null, clazzId, 13, 1, CURRENT_DATE(), NOW(),tempInoutTime  from palm_student_clazz where userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =13  and type=1 and userid=tempuserId ) )//
					
  				end if// 
 				UNTIL done END REPEAT//
 				CLOSE cur_15//
				set done = 0//
				end if//
				select status into tempstatus from palm_checkattendance_order where id=14//
				if tempstatus=0 then				
				open cur_16//
 				REPEAT
 				 FETCH cur_16 INTO tempInoutTime,tempuserId//
 				 if not done then
					if exists(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =8  and userid=tempuserId) then
					  delete from palm_checkattendance where createDate=CURRENT_DATE() and  status =8  and userid=tempuserId//
					end if//
  					insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select userId,null, clazzId, 14, 1, CURRENT_DATE(), NOW(),tempInoutTime  from palm_student_clazz where userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =14  and type=1 and userid=tempuserId ) )//
					
  				end if// 
 				UNTIL done END REPEAT//
 				CLOSE cur_16//
				set done = 0//
				end if//
			end if//
		end if//
		end if//
		if temptype = 1 then
			if tempBeginTime is not null then
				if ( currenttime > tempBeginTime &&  currenttime < tempEndTime) then
					select status into tempstatus from palm_checkattendance_order where id=22//
					if tempstatus=0 then
				 		open cur_17//
 						 REPEAT
 						 FETCH cur_17 INTO tempInoutTime,tempuserId//
 				 		if not done then
  							insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select userId,null, clazzId, 22, 1, CURRENT_DATE(), NOW(),tempInoutTime  from palm_student_clazz where userId = tempuserId and NOT EXISTS (select userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=22 and type=1 and userid=tempuserId ))// 
  						end if//
 						UNTIL done END REPEAT//
 						CLOSE cur_17//
						set done = 0//
					end if//
					select status into tempstatus from palm_checkattendance_order where id=23//
					if tempstatus=0 then			
					open cur_18//
 					REPEAT
 					 FETCH cur_18 INTO tempInoutTime,tempuserId//				
 					 if not done then
						if not exists(select userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=22 and userid=tempuserId )  then					
  							insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select userId,null, clazzId, 23, 1, CURRENT_DATE(), NOW(),tempInoutTime  from palm_student_clazz where userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status in(21,23 ) and type=1 and userid=tempuserId ) )//
  						end if//
					end if// 
 					UNTIL done END REPEAT//
 					CLOSE cur_18//
					set done = 0//
					end if//
				
					select status into tempstatus from palm_checkattendance_order where id=24//
					if tempstatus=0 then				
					open cur_19//
 					REPEAT
 					 FETCH cur_19 INTO tempInoutTime,tempuserId//
 					 if not done then
  						insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select userId,null, clazzId, 24, 1, CURRENT_DATE(), NOW(),tempInoutTime  from palm_student_clazz where userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =24  and type=1 and userid=tempuserId ) )//
					
  					end if// 
 					UNTIL done END REPEAT//
 					CLOSE cur_19//
					set done = 0//
					end if//	
				end if//
				if ( currenttime > tempEndTime) then
					select status into tempstatus from palm_checkattendance_order where id=25//
					if tempstatus=0 then				
					open cur_20//
 					REPEAT
 					 FETCH cur_20 INTO tempInoutTime,tempuserId//
 					 if not done then
						if exists(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =26  and userid=tempuserId) then
					  		delete from palm_checkattendance where createDate=CURRENT_DATE() and  status =26  and userid=tempuserId//
						end if//
						if exists(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=24   and userid=tempuserId) then
							delete from  palm_checkattendance where createDate=CURRENT_DATE() and  status=24   and userid=tempuserId//
						end if//
  						insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select userId,null, clazzId, 25, 1, CURRENT_DATE(), NOW(),tempInoutTime  from palm_student_clazz where userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =25  and type=1 and userid=tempuserId ) )//
					
  					end if// 
 					UNTIL done END REPEAT//
 					CLOSE cur_20//
					set done = 0//
					end if//
					select status into tempstatus from palm_checkattendance_order where id=26//
					if tempstatus=0 then				
					open cur_21//
 					REPEAT
 					 FETCH cur_21 INTO tempuserId//
 				 	if not done then
  						insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime)  (select userId,null, clazzId, 26, 1, CURRENT_DATE(), NOW()  from palm_student_clazz where userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status=26  and type=1 and userid=tempuserId ) )//
					
  					end if// 
 					UNTIL done END REPEAT//
 					CLOSE cur_21//
					set done = 0//
					end if//
					select status into tempstatus from palm_checkattendance_order where id=27//
					if tempstatus=0 then				
					open cur_23//
 					REPEAT
 				 	FETCH cur_23 INTO tempInoutTime,tempuserId//
 				 	if not done then
						if exists(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =26  and userid=tempuserId) then
					 	 delete from palm_checkattendance where createDate=CURRENT_DATE() and  status =26  and userid=tempuserId//
						end if//
  						insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select userId,null, clazzId, 27, 1, CURRENT_DATE(), NOW(),tempInoutTime  from palm_student_clazz where userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =27  and type=1 and userid=tempuserId ) )//
					
  					end if// 
 					UNTIL done END REPEAT//
 					CLOSE cur_23//
					set done = 0//
					end if//
					select status into tempstatus from palm_checkattendance_order where id=28//
					if tempstatus=0 then				
					open cur_24//
 					REPEAT
 				 	FETCH cur_24 INTO tempInoutTime,tempuserId//
 				 	if not done then
						if exists(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =26  and userid=tempuserId) then
					 	 delete from palm_checkattendance where createDate=CURRENT_DATE() and  status =26  and userid=tempuserId//
						end if//
  						insert  into palm_checkattendance(userId,departmentId,clazzId,status, type, createDate, createTime,inoutTime)  (select userId,null, clazzId, 28, 1, CURRENT_DATE(), NOW(),tempInoutTime  from palm_student_clazz where userId = tempuserId and NOT EXISTS(select distinct userid from palm_checkattendance where createDate=CURRENT_DATE() and  status =28  and type=1 and userid=tempuserId ) )//
					
  					end if// 
 					UNTIL done END REPEAT//
 					CLOSE cur_24//
					set done = 0//
					end if//
				end if//
			end if//
		end if//
	end if//
END;

DROP PROCEDURE IF EXISTS `modifyGradeNamePro`;
CREATE  PROCEDURE `modifyGradeNamePro`() 
BEGIN 
	DECLARE currentMonth, currentYear,gradeYear,gradeId,gradeType, betweenYear INT// 
	DECLARE gradeCreateYear VARCHAR(50)// 
	DECLARE done INT DEFAULT 0// 
	DECLARE cur_1 CURSOR FOR SELECT id FROM palm_grade WHERE state=0// 
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1// 
	SELECT MONTH(NOW()) INTO currentMonth// 
	SELECT YEAR(NOW()) INTO currentYear// 
	OPEN cur_1// 
	 REPEAT 
	 FETCH cur_1 INTO gradeId// 
	 IF NOT done THEN 
		SELECT createYear,TYPE INTO gradeCreateYear , gradeType FROM palm_grade WHERE id=gradeId// 
		IF LENGTH(gradeCreateYear) > 4 THEN 
							IF currentMonth = 8 THEN 
								SELECT (currentYear- CONVERT(LEFT(gradeCreateYear,4),SIGNED)) INTO betweenYear// 
								IF gradeType = '0' THEN 
									IF betweenYear > 2 THEN 
										UPDATE palm_grade SET NAME='大班' ,state=1 ,updateTime=NOW() WHERE id=gradeId// 
									ELSEIF betweenYear = 2 THEN 
										UPDATE palm_grade SET NAME='大班',updateTime=NOW() WHERE id=gradeId//
									ELSEIF betweenYear = 1 THEN 
										UPDATE palm_grade SET NAME='中班',updateTime=NOW() WHERE id=gradeId// 
									ELSE 
										UPDATE palm_grade SET NAME='小班',updateTime=NOW() WHERE id=gradeId// 
									END IF// 
								ELSEIF gradeType='1' THEN 
									IF betweenYear > 5 THEN 
											UPDATE palm_grade SET NAME='六年级' ,state=1 ,updateTime=NOW() WHERE id=gradeId// 
									ELSE 
											UPDATE palm_grade SET NAME=CONCAT(getUpperNum(betweenYear),'年级'),updateTime=NOW() WHERE id=gradeId// 
									END IF// 
								ELSEIF gradeType = '2' THEN 
									IF betweenYear > 2 THEN 
											UPDATE palm_grade SET NAME='九年级',state=1 ,updateTime=NOW() WHERE id=gradeId// 
									ELSE 
											UPDATE palm_grade SET NAME=CONCAT(getUpperNum(betweenYear+6),'年级'),updateTime=NOW() WHERE id=gradeId// 
									END IF// 
								ELSE 									
									IF betweenYear > 2 THEN 
											UPDATE palm_grade SET NAME='三年级',state=1,updateTime=NOW() WHERE id=gradeId//
									ELSE 
											UPDATE palm_grade SET NAME=CONCAT(getUpperNum(betweenYear),'年级'),updateTime=NOW() WHERE id=gradeId// 
									END IF// 
								END IF// 			
							END IF//					
		ELSEIF 	LENGTH(gradeCreateYear) = 4 THEN 
							IF currentMonth = 8 THEN 
								SELECT (currentYear- CONVERT(gradeCreateYear,SIGNED)) INTO betweenYear// 
								IF gradeType = '0' THEN 
									IF betweenYear > 2 THEN 
										UPDATE palm_grade SET NAME='大班' ,state=1 ,updateTime=NOW() WHERE id=gradeId// 
									ELSEIF betweenYear = 2 THEN 
										UPDATE palm_grade SET NAME='大班' ,updateTime=NOW() WHERE id=gradeId// 
									ELSEIF betweenYear = 1 THEN 
										UPDATE palm_grade SET NAME='中班' ,updateTime=NOW() WHERE id=gradeId//
									ELSE 
										UPDATE palm_grade SET NAME='小班' ,updateTime=NOW() WHERE id=gradeId//
									END IF//
								ELSEIF gradeType='1' THEN
									IF betweenYear > 5 THEN 
											UPDATE palm_grade SET NAME='六年级' ,state=1 ,updateTime=NOW() WHERE id=gradeId// 
									ELSE 
											UPDATE palm_grade SET NAME=CONCAT(getUpperNum(betweenYear),'年级') ,updateTime=NOW() WHERE id=gradeId// 
									END IF// 
								ELSEIF gradeType = '2' THEN 
									IF betweenYear > 2 THEN 
											UPDATE palm_grade SET NAME='九年级' ,state=1 ,updateTime=NOW() WHERE id=gradeId// 
									ELSE 
											UPDATE palm_grade SET NAME=CONCAT(getUpperNum(betweenYear+6),'年级') ,updateTime=NOW() WHERE id=gradeId// 
									END IF// 								
								ELSE 
									IF betweenYear > 2 THEN 
											UPDATE palm_grade SET NAME='三年级',state=1 ,updateTime=NOW() WHERE id=gradeId// 
									ELSE 
											UPDATE palm_grade SET NAME=CONCAT(getUpperNum(betweenYear),'年级') ,updateTime=NOW() WHERE id=gradeId// 
									END IF//
								END IF// 
							END IF// 						
		END IF//
	END IF//
	UNTIL done END REPEAT//
	CLOSE cur_1//
END;

DROP PROCEDURE IF EXISTS `modifyUserMessageStatusPro`;
CREATE PROCEDURE `modifyUserMessageStatusPro`() 
BEGIN
	DECLARE messId,mCount,mType INT//
	DECLARE mEndTime VARCHAR(50)//
	DECLARE today DATE//
	DECLARE done INT DEFAULT 0//
	DECLARE cur_1 CURSOR FOR SELECT id FROM palm_order_message_user WHERE status=0//
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1//
	SELECT CURRENT_DATE() INTO today//
	open cur_1//
		REPEAT 
			FETCH cur_1 INTO messId//
			if not done then 
				select count,type,endTime into mCount,mType,mEndTime from palm_order_message_user where id=messId//
				IF mType = '0' then
					if today > mEndTime THEN
						update palm_order_message_user set status=1,updateTime=NOW() where id=messId//
					end if//
				ELSEIF 	mType = '1' THEN 
					if mCount = '0' THEN
						update palm_order_message_user set status=1,updateTime=NOW() where id=messId//
					end if//

				END IF//
			end if//
		UNTIL done END REPEAT//
	CLOSE cur_1//
END;

DROP FUNCTION IF EXISTS `getClazzName`;
CREATE  FUNCTION `getClazzName`(`in_clazzId` INTEGER) RETURNS varchar(50) CHARSET utf8mb4 
BEGIN 
	 DECLARE out_ClazzName         VARCHAR(50)//
	 SELECT CONCAT( 
			   CASE 
						WHEN g.type = 0 THEN '' 
						WHEN g.type = 1 THEN '' 
						WHEN g.type = 2 THEN '' 
			      WHEN g.type = 3 THEN '高中' 
			    END 
			,c.clazzName) INTO out_ClazzName 
	 FROM palm_clazz c , palm_grade g 
	 WHERE c.gradeId = g.id 
	 and c.id = in_clazzId//	 
   RETURN out_ClazzName//  
END;

DROP FUNCTION IF EXISTS `getGradeName`; 
CREATE  FUNCTION `getGradeName`(`in_gradeId` INTEGER) RETURNS varchar(50) CHARSET utf8mb4 
BEGIN 
	 DECLARE out_GradeName         VARCHAR(50)// 
	 SELECT CONCAT( 
			   CASE 
			      WHEN g.type = 0 THEN '' 
			      WHEN g.type = 1 THEN '' 
			      WHEN g.type = 2 THEN '' 
			      WHEN g.type = 3 THEN '高中' 
			    END 
			, g.name) INTO out_GradeName 
	 FROM palm_grade g 
	 where g.id = in_gradeId// 	 
   RETURN out_GradeName//   
END;
		
DROP FUNCTION IF EXISTS `getUpperNum`;
CREATE FUNCTION `getUpperNum`(`in_num` INTEGER) RETURNS VARCHAR(5) CHARSET utf8mb4 
BEGIN
	DECLARE out_num VARCHAR(5)//
 	IF in_num = 0 THEN  		SET out_num = '一'//	
 	ELSEIF in_num = 1 THEN 		SET out_num = '二'// 	
 	ELSEIF in_num = 2 THEN 		SET out_num='三'// 	
 	ELSEIF in_num = 3 THEN 		SET out_num='四'// 	
 	ELSEIF in_num = 4 THEN 		SET out_num='五'// 	
 	ELSEIF in_num = 5 THEN 		SET out_num='六'// 	
 	ELSEIF in_num = 6 THEN 		SET out_num='七'// 	
 	ELSEIF in_num = 7 THEN 		SET out_num='八'//	
 	ELSEIF in_num = 8 THEN 		SET out_num='九'// 	
 	END IF// 			
RETURN out_num// 
END;

DROP FUNCTION IF EXISTS `getOrderMessageUser`;
CREATE FUNCTION `getOrderMessageUser`(`userId_` INT) RETURNS INT(11) COMMENT '判断是否购买短信套餐' 
BEGIN
	SELECT count(*) INTO @counnt from palm_order_message_user where userId=userId_ and `status`=0//
	RETURN @counnt//
END;

DROP EVENT IF EXISTS `e_modifyGrade`;
CREATE DEFINER=`palmSchool`@`121.199.27.191` EVENT `e_modifyGrade` ON SCHEDULE EVERY 12 MONTH STARTS '2016-08-25 23:30:00' ON COMPLETION PRESERVE ENABLE DO call modifyGradeNamePro();
DROP EVENT IF EXISTS `e_modifyUserMessageStatus`;
CREATE DEFINER=`palmSchool`@`121.199.27.191` EVENT `e_modifyUserMessageStatus` ON SCHEDULE EVERY 100 SECOND STARTS '2016-08-01 10:53:45' ON COMPLETION PRESERVE ENABLE DO CALL modifyUserMessageStatusPro();
alter event e_modifyGrade ON COMPLETION PRESERVE ENABLE; 
alter event e_modifyUserMessageStatus ON COMPLETION PRESERVE ENABLE; 
set global event_scheduler=1; 


DROP TABLE IF EXISTS `user_data_change_records`;
CREATE TABLE `user_data_change_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `objectId` int(11) DEFAULT NULL COMMENT '操作对象Id',
  `oprateType` char(1) DEFAULT NULL COMMENT '操作类型：0 add、1 update、2 delete',
  `ctime` datetime DEFAULT NULL COMMENT '此条记录生成时间',
  `status` char(1) NOT NULL DEFAULT '0' COMMENT '同步状态：0 未同步，1 已同步',
  `failCount` tinyint(11) NOT NULL DEFAULT '0' COMMENT '同步失败次数',
  `syncTarget` char(2) DEFAULT NULL COMMENT '同步表：0subject,1userbase,2userdetail,3grade,4clazz,5course_semester,6course_time,7course,8org,9user_org',
  `syncTime` datetime DEFAULT NULL COMMENT '同步时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户操作日志表';

DROP TABLE IF EXISTS `user_data_change_records_detail`;
CREATE TABLE `user_data_change_records_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '变动记录详细表id',
  `targetId` int(11) NOT NULL COMMENT '用户操作记录表id',
  `operationClass` varchar(50) DEFAULT NULL COMMENT '操作表表名',
  `propertyName` varchar(50) DEFAULT NULL COMMENT '操作表属性名',
  `propertyValue` varchar(50) DEFAULT NULL COMMENT '操作表属性值',
  `operationType` char(1) DEFAULT NULL COMMENT '操作表操作类型0add 1update 2delete',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='用户操作记录详情表';
    
DROP TRIGGER IF EXISTS `tr_user_department_insert`;
CREATE TRIGGER `tr_user_department_insert` AFTER INSERT ON palm_user_department 
    FOR EACH ROW BEGIN
			INSERT INTO user_data_change_records SET objectId=new.id,oprateType = 0, ctime=NOW(),status='0',syncTarget=9,failCount=0//
			set @targetId = (select max(id) from user_data_change_records)//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='ID',propertyValue= new.id//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='ORG_ID',propertyValue= new.departmentId//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='USER_ID',propertyValue= new.userId//
END;

DROP TRIGGER IF EXISTS `tr_user_department_update`;
CREATE TRIGGER `tr_user_department_update` AFTER UPDATE ON palm_user_department 
    FOR EACH ROW BEGIN
			IF new.departmentId != old.departmentId OR old.userId != new.userId THEN
				set @departmentId = new.id//
				set @objectId = (SELECT id from user_data_change_records where status='0' and syncTarget=9 and objectId=@departmentId)//
				IF @objectId >0 THEN 
					DELETE FROM user_data_change_records_detail where targetId =@objectId//
					set @targetId = @objectId//
				ELSE	
					INSERT INTO user_data_change_records SET objectId=new.id,oprateType = 1,ctime=NOW(),status='0',syncTarget=9,failCount=0//
					set @targetId = (select max(id) from user_data_change_records)//
				END IF//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='ID',propertyValue= new.id//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='ORG_ID',propertyValue= new.departmentId//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='USER_ID',propertyValue= new.userId//
			END IF//
END;
    
    
DROP TRIGGER IF EXISTS `tr_user_department_delete`;
CREATE TRIGGER `tr_user_department_delete` AFTER DELETE ON palm_user_department 
    FOR EACH ROW BEGIN
			set @departmentId = old.id//
			set @oprateType = (SELECT oprateType from user_data_change_records where status='0' and syncTarget=9 and objectId=@departmentId)// 
			IF (@oprateType is NOT NULL) THEN 
				set @objectId = (SELECT id from user_data_change_records where status='0' and syncTarget=9 and objectId=@departmentId)//
				DELETE FROM user_data_change_records_detail where targetId =@objectId//
				DELETE FROM user_data_change_records where id = @objectId//
				IF (@oprateType ='1' || @oprateType ='2') THEN 
					INSERT INTO user_data_change_records SET objectId=@departmentId, oprateType = 2, ctime=NOW(),status='0',syncTarget=9,failCount=0//
				END IF//
			ELSE
				INSERT INTO user_data_change_records SET objectId=@departmentId, oprateType = 2, ctime=NOW(),status='0',syncTarget=9,failCount=0//
			END IF//
END;
    
    
DROP TRIGGER IF EXISTS `tr_time_insert`;
CREATE TRIGGER `tr_time_insert` AFTER INSERT ON palm_curriculum_time 
    FOR EACH ROW BEGIN
			INSERT INTO user_data_change_records SET objectId=new.id,oprateType = 0, ctime=NOW(),status='0',syncTarget=6,failCount=0//
			set @targetId = (select max(id) from user_data_change_records)//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='ID',propertyValue= new.id//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='BEGIN_TIME',propertyValue= new.beginTime//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='END_TIME',propertyValue= new.endTime//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='SEMESTER_ID',propertyValue= new.semesterId//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='SORT_NO',propertyValue= new.num//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='CREATE_TIME',propertyValue= new.createTime//
END;

    
DROP TRIGGER IF EXISTS `tr_time_update`;
CREATE TRIGGER `tr_time_update` AFTER UPDATE ON palm_curriculum_time 
    FOR EACH ROW BEGIN
			IF new.beginTime != old.beginTime OR old.endTime != new.endTime OR old.semesterId != new.semesterId OR old.num != new.num THEN
				set @timeId = new.id//
				set @objectId = (SELECT id from user_data_change_records where status='0' and syncTarget=6 and objectId=@timeId)// 
				IF @objectId >0 THEN 
					DELETE FROM user_data_change_records_detail where targetId =@objectId//
					set @targetId = @objectId//
				ELSE	
					INSERT INTO user_data_change_records SET objectId=new.id,oprateType = 1,ctime=NOW(),status='0',syncTarget=6,failCount=0//
					set @targetId = (select max(id) from user_data_change_records)//
				END IF//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='ID',propertyValue= new.id//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='BEGIN_TIME',propertyValue= new.beginTime//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='END_TIME',propertyValue= new.endTime//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='SEMESTER_ID',propertyValue= new.semesterId//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='SORT_NO',propertyValue= new.num//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='CREATE_TIME',propertyValue= new.createTime//
			END IF//
END;
    
DROP TRIGGER IF EXISTS `tr_time_delete`;
CREATE TRIGGER `tr_time_delete` AFTER DELETE ON palm_curriculum_time 
    FOR EACH ROW BEGIN
			set @timeId = old.id//
			set @oprateType = (SELECT oprateType from user_data_change_records where status='0' and syncTarget=6 and objectId=@timeId)// 
			IF (@oprateType is NOT NULL) THEN 
				set @objectId = (SELECT id from user_data_change_records where status='0' and syncTarget=6 and objectId=@timeId)//
				DELETE FROM user_data_change_records_detail where targetId =@objectId//
				DELETE FROM user_data_change_records where id = @objectId//
				IF (@oprateType ='1' || @oprateType ='2') THEN 	
					INSERT INTO user_data_change_records SET objectId=@timeId, oprateType = 2, ctime=NOW(),status='0',syncTarget=6,failCount=0//
				END IF//
			ELSE
				INSERT INTO user_data_change_records SET objectId=@timeId, oprateType = 2, ctime=NOW(),status='0',syncTarget=6,failCount=0//
			END IF//
END;
    
    
DROP TRIGGER IF EXISTS `tr_subject_insert`;
CREATE TRIGGER `tr_subject_insert` AFTER INSERT ON palm_subject 
    FOR EACH ROW BEGIN
			IF (new.subjectname IS NOT NULL && new.subjectname != '') THEN 
				INSERT INTO user_data_change_records SET objectId=new.id,oprateType = 0, ctime=NOW(),status='0',syncTarget=0,failCount=0//
				set @targetId = (select max(id) from user_data_change_records)//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='ID',propertyValue= new.id//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='NAME',propertyValue= new.subjectname//
			END IF//
END;


    
DROP TRIGGER IF EXISTS `tr_subject_update`;
CREATE TRIGGER `tr_subject_update` AFTER UPDATE ON palm_subject 
    FOR EACH ROW BEGIN
			IF (new.subjectname IS NOT NULL && new.subjectname != '') THEN 
				set @subjectId = new.id//
				set @objectId = (SELECT id from user_data_change_records where status='0' and syncTarget=0 and objectId=@subjectId)// 
				IF @objectId >0 THEN 
					DELETE FROM user_data_change_records_detail where targetId =@objectId//
					set @targetId = @objectId//
				ELSE	
					INSERT INTO user_data_change_records SET objectId=new.id,oprateType = 1,ctime=NOW(),status='0',syncTarget=0,failCount=0//
					set @targetId = (select max(id) from user_data_change_records)//
				END IF//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='ID',propertyValue= new.id//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='NAME',propertyValue= new.subjectName//
			END IF//
END;
    
    
DROP TRIGGER IF EXISTS `tr_subject_delete`;
CREATE TRIGGER `tr_subject_delete` AFTER DELETE ON palm_subject 
    FOR EACH ROW BEGIN
			IF (old.subjectname IS NOT NULL && old.subjectname != '') THEN
				set @subjectId = old.id//
				set @oprateType = (SELECT oprateType from user_data_change_records where status='0' and syncTarget=0 and objectId=@subjectId)//	
				IF (@oprateType is NOT NULL) THEN 	
					set @objectId = (SELECT id from user_data_change_records where status='0' and syncTarget=0 and objectId=@subjectId)//
					DELETE FROM user_data_change_records_detail where targetId =@objectId//
					DELETE FROM user_data_change_records where id = @objectId//
					IF (@oprateType ='1' || @oprateType ='2') THEN 		
						INSERT INTO user_data_change_records SET objectId=@subjectId, oprateType = 2, ctime=NOW(),status='0',syncTarget=0,failCount=0//
					END IF//
				ELSE
					INSERT INTO user_data_change_records SET objectId=@subjectId, oprateType = 2, ctime=NOW(),status='0',syncTarget=0,failCount=0//
				END IF//
			END IF//
END;
    
DROP TRIGGER IF EXISTS `tr_semester_insert`;
CREATE TRIGGER `tr_semester_insert` AFTER INSERT ON palm_curriculum_semester 
    FOR EACH ROW BEGIN
			set @newStatus = new.usable//
			IF new.usable = 1 THEN set @newStatus =1//	
			ELSEIF new.usable = 2 THEN set @newStatus =0//
			END IF//
			INSERT INTO user_data_change_records SET objectId=new.id, oprateType = 0, ctime=NOW(),status='0',syncTarget=5,failCount=0//
			set @targetId = (select max(id) from user_data_change_records)//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='ID',propertyValue= new.id//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='BEGIN_DATE',propertyValue= new.beginDate//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='END_DATE',propertyValue= new.endDate//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='STATUS',propertyValue= @newStatus//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='CREATE_TIME',propertyValue= new.createTime//
END;
    
    
DROP TRIGGER IF EXISTS `tr_semester_update`;
CREATE TRIGGER `tr_semester_update` AFTER UPDATE ON palm_curriculum_semester
    FOR EACH ROW BEGIN
			IF new.beginDate != old.beginDate OR old.endDate != new.endDate OR old.usable != new.usable THEN
				set @semester = new.id//
				set @objectId = (SELECT id from user_data_change_records where status='0' and syncTarget=5 and objectId=@semester)//		
				set @newStatus = new.usable//
				IF new.usable = 1 THEN set @newStatus =1//		
				ELSEIF new.usable = 2 THEN set @newStatus =0//
				END IF//
				set @targetId = 0//
				IF @objectId >0 THEN 	
					DELETE FROM user_data_change_records_detail where targetId =@objectId//
					set @targetId = @objectId//
				ELSE	
					INSERT INTO user_data_change_records SET objectId=new.id, oprateType = 1, ctime=NOW(),status='0',syncTarget=5,failCount=0//
					set @targetId = (select max(id) from user_data_change_records)//
				END IF//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='ID',propertyValue= new.id//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='BEGIN_DATE',propertyValue= new.beginDate//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='END_DATE',propertyValue= new.endDate//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='STATUS',propertyValue= @newStatus//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='CREATE_TIME',propertyValue= new.createTime//
			END IF//
END;
    
    
    
DROP TRIGGER IF EXISTS `tr_semester_delete`;
CREATE TRIGGER `tr_semester_delete` AFTER DELETE ON palm_curriculum_semester 
    FOR EACH ROW BEGIN
		set @semesterId = old.id//
		set @oprateType = (SELECT oprateType from user_data_change_records where status='0' and syncTarget=5 and objectId=@semesterId)//	
		IF (@oprateType is NOT NULL) THEN 	
			set @objectId = (SELECT id from user_data_change_records where status='0' and syncTarget=5 and objectId=@semesterId)//
			DELETE FROM user_data_change_records_detail where targetId =@objectId//
			DELETE FROM user_data_change_records where id = @objectId//
			IF (@oprateType ='1' || @oprateType ='2') THEN 	
				INSERT INTO user_data_change_records SET objectId=@semesterId, oprateType = 2, ctime=NOW(),status='0',syncTarget=5,failCount=0//
			END IF//
		ELSE
			INSERT INTO user_data_change_records SET objectId=@semesterId, oprateType = 2, ctime=NOW(),status='0',syncTarget=5,failCount=0//
		END IF//
END;

    
DROP TRIGGER IF EXISTS `tr_grade_insert`;
CREATE TRIGGER `tr_grade_insert` AFTER INSERT ON palm_grade 
    FOR EACH ROW BEGIN
			set @nowYear = year(NOW())//
			set @createYear = LEFT(new.createYear,4)//
			set @gradeType = new.type//
			set @newType = 0//
			set @newState = 0//
			IF (new.state = 0) THEN
				SET @newState = 1//
			ELSE
				SET @newState = 0//
			END IF//
			IF (new.state = 0) THEN
				IF (@gradeType is not NULL && @gradeType ='0') THEN 
					set @newType = @nowYear-@createYear+1//
				ELSEIF @gradeType ='1' THEN 
					set @newType = @nowYear-@createYear+5//
				ELSEIF @gradeType ='2' THEN	
					set @newType = @nowYear-@createYear+11//
				ELSEIF @gradeType ='3' THEN	
					set @newType = @nowYear-@createYear+14//
				END IF//
				INSERT INTO user_data_change_records SET objectId=new.id,oprateType = 0, ctime=NOW(),status='0',syncTarget=3,failCount=0//
				set @targetId = (select max(id) from user_data_change_records)//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='ID',propertyValue= new.id//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='NAME',propertyValue= new.name//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='TYPE',propertyValue= @newType//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='STATE',propertyValue= @newState//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='CREATE_TIME',propertyValue= new.createTime//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='UPDATE_TIME',propertyValue= new.updateTime//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='YEAR',propertyValue= new.createYear//
			END IF//
END;

    
    
DROP TRIGGER IF EXISTS `tr_grade_update`;
CREATE TRIGGER `tr_grade_update` AFTER UPDATE ON palm_grade 
    FOR EACH ROW BEGIN
			IF new.name != old.name OR new.state != old.state OR old.type != new.type OR old.updateTime != new.updateTime OR old.createYear != new.createYear THEN
				set @gradeId = new.id//
				set @nowYear = year(NOW())//
				set @createYear = LEFT(new.createYear,4)//
				set @gradeType = new.type//
				set @newType = 0//
				set @newState = 0//
				IF (new.state = 0) THEN
					SET @newState = 1//
				ELSE
					SET @newState = 0//
				END IF//
				set @targetId = 0//
				IF (@gradeType is not NULL && @gradeType ='0') THEN 
					set @newType = @nowYear-@createYear+1//
				ELSEIF @gradeType ='1' THEN 
					set @newType = @nowYear-@createYear+5//
				ELSEIF @gradeType ='2' THEN	
					set @newType = @nowYear-@createYear+11//
				ELSEIF @gradeType ='3' THEN	
					set @newType = @nowYear-@createYear+14//
				END IF//
				set @objectId = (SELECT id from user_data_change_records where status='0' and syncTarget=3 and objectId=@gradeId)//	
				IF @objectId >0 THEN 	
					DELETE FROM user_data_change_records_detail where targetId =@objectId//
					set @targetId = @objectId//
				ELSE	
					INSERT INTO user_data_change_records SET objectId=new.id,oprateType = 1,ctime=NOW(),status='0',syncTarget=3,failCount=0//
					set @targetId = (select max(id) from user_data_change_records)//
				END IF//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='ID',propertyValue= new.id//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='NAME',propertyValue= new.name//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='TYPE',propertyValue= @newType//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='STATE',propertyValue= @newState//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='CREATE_TIME',propertyValue= new.createTime//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='UPDATE_TIME',propertyValue= new.updateTime//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='YEAR',propertyValue= new.createYear//
			END IF//
END;

    
DROP TRIGGER IF EXISTS `tr_grade_delete`;
CREATE TRIGGER `tr_grade_delete` AFTER DELETE ON palm_grade 
    FOR EACH ROW BEGIN
			set @gradeId = old.id//
			set @oprateType = (SELECT oprateType from user_data_change_records where status='0' and syncTarget=3 and objectId=@gradeId)//	
			IF (@oprateType is NOT NULL) THEN 	
				set @objectId = (SELECT id from user_data_change_records where status='0' and syncTarget=3 and objectId=@gradeId)//
				DELETE FROM user_data_change_records_detail where targetId =@objectId//
				DELETE FROM user_data_change_records where id = @objectId//
				IF (@oprateType ='1' || @oprateType ='2') THEN 	
					INSERT INTO user_data_change_records SET objectId=@gradeId, oprateType = 2, ctime=NOW(),status='0',syncTarget=3,failCount=0//
				END IF//
			ELSE
				INSERT INTO user_data_change_records SET objectId=@gradeId, oprateType = 2, ctime=NOW(),status='0',syncTarget=3,failCount=0//
			END IF//
END;
    
    
DROP TRIGGER IF EXISTS `tr_department_insert`;
CREATE TRIGGER `tr_department_insert` AFTER INSERT ON palm_department 
    FOR EACH ROW BEGIN
			INSERT INTO user_data_change_records SET objectId=new.id,oprateType = 0, ctime=NOW(),status='0',syncTarget=8,failCount=0//
			set @targetId = (select max(id) from user_data_change_records)//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='ID',propertyValue= new.id//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='NAME',propertyValue= new.departmentName//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='CODE',propertyValue= new.code//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='IS_ATTENDANCE',propertyValue= new.isAttendance//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='CREATE_TIME',propertyValue= new.createTime//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='UPDATE_TIME',propertyValue= new.updateTime//
END;

    
DROP TRIGGER IF EXISTS `tr_department_update`;
CREATE TRIGGER `tr_department_update` AFTER UPDATE ON palm_department 
    FOR EACH ROW BEGIN
			IF new.departmentName != old.departmentName OR old.code != new.code OR old.isAttendance != new.isAttendance OR old.updateTime != new.updateTime THEN
				set @departmentId = new.id//
				set @objectId = (SELECT id from user_data_change_records where status='0' and syncTarget=8 and objectId=@departmentId)// 
				IF @objectId >0 THEN 
					DELETE FROM user_data_change_records_detail where targetId =@objectId//
					set @targetId = @objectId//
				ELSE	
					INSERT INTO user_data_change_records SET objectId=new.id,oprateType = 1,ctime=NOW(),status='0',syncTarget=8,failCount=0//
					set @targetId = (select max(id) from user_data_change_records)//
				END IF//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='ID',propertyValue= new.id//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='NAME',propertyValue= new.departmentName//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='CODE',propertyValue= new.code//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='IS_ATTENDANCE',propertyValue= new.isAttendance//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='CREATE_TIME',propertyValue= new.createTime//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='UPDATE_TIME',propertyValue= new.updateTime//
			END IF//
END;
    
    
DROP TRIGGER IF EXISTS `tr_department_delete`;
CREATE TRIGGER `tr_department_delete` AFTER DELETE ON palm_department 
    FOR EACH ROW BEGIN
			set @departmentId = old.id//
			set @oprateType = (SELECT oprateType from user_data_change_records where status='0' and syncTarget=8 and objectId=@departmentId)//	
			IF (@oprateType is NOT NULL) THEN 	
				set @objectId = (SELECT id from user_data_change_records where status='0' and syncTarget=8 and objectId=@departmentId)//
				DELETE FROM user_data_change_records_detail where targetId =@objectId//
				DELETE FROM user_data_change_records where id = @objectId//
				IF (@oprateType ='1' || @oprateType ='2') THEN 	
					INSERT INTO user_data_change_records SET objectId=@departmentId, oprateType = 2, ctime=NOW(),status='0',syncTarget=8,failCount=0//
				END IF//
			ELSE
				INSERT INTO user_data_change_records SET objectId=@departmentId, oprateType = 2, ctime=NOW(),status='0',syncTarget=8,failCount=0//
			END IF//
END;
    
    
DROP TRIGGER IF EXISTS `tr_curriculum_insert`;
CREATE TRIGGER `tr_curriculum_insert` AFTER INSERT ON palm_curriculum 
    FOR EACH ROW BEGIN
			SET @subjectName =new.subjectName//
			SET @subjectId = (SELECT id from palm_subject where subjectName =@subjectName)//
			IF (@subjectId is NULL) THEN
				INSERT INTO palm_subject SET subjectName = @subjectName//
				SET @subjectId = (SELECT MAX(id) FROM palm_subject)//
			END IF//
			INSERT INTO user_data_change_records SET objectId=new.id,oprateType = 0, ctime=NOW(),status='0',syncTarget=7,failCount=0//
			set @targetId = (select max(id) from user_data_change_records)//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='ID',propertyValue= new.id//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='CLAZZ_ID',propertyValue= new.clazzId//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='SUBJECT_ID',propertyValue= @subjectId//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='TEACHER_ID',propertyValue= new.subjectsUser//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='SEMESTER_ID',propertyValue= new.semesterId//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='WEEK_ID',propertyValue= new.weekId//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='TIME_ID',propertyValue= new.timeId//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='CREATE_TIME',propertyValue= new.createTime//
END;

    
DROP TRIGGER IF EXISTS `tr_curriculum_update`;
CREATE TRIGGER `tr_curriculum_update` AFTER UPDATE ON palm_curriculum
    FOR EACH ROW BEGIN
			IF new.clazzId != old.clazzId OR old.subjectName != new.subjectName OR old.subjectsUser != new.subjectsUser OR old.semesterId != new.semesterId OR old.weekId != new.weekId OR old.timeId != new.timeId THEN
				set @curriculumId = new.id//
				SET @subjectName =new.subjectName//
				SET @subjectId = (SELECT id from palm_subject where subjectName =@subjectName)//
				IF (@subjectId is NULL) THEN
					INSERT INTO palm_subject SET subjectName = @subjectName//
					SET @subjectId = (SELECT MAX(id) FROM palm_subject)//
				END IF//
				set @objectId = (SELECT id from user_data_change_records where status='0' and syncTarget=7 and objectId=@curriculumId)// 
				IF @objectId >0 THEN 	
					DELETE FROM user_data_change_records_detail where targetId =@objectId//
					set @targetId = @objectId//
				ELSE	
					INSERT INTO user_data_change_records SET objectId=new.id,oprateType = 1,ctime=NOW(),status='0',syncTarget=7,failCount=0//
					set @targetId = (select max(id) from user_data_change_records)//
				END IF//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='ID',propertyValue= new.id//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='CLAZZ_ID',propertyValue= new.clazzId//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='SUBJECT_ID',propertyValue= @subjectId//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='TEACHER_ID',propertyValue= new.subjectsUser//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='SEMESTER_ID',propertyValue= new.semesterId//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='WEEK_ID',propertyValue= new.weekId//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='TIME_ID',propertyValue= new.timeId//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='CREATE_TIME',propertyValue= new.createTime//
			END IF//
END;
    
    
DROP TRIGGER IF EXISTS `tr_curriculum_delete`;
CREATE TRIGGER `tr_curriculum_delete` AFTER DELETE ON palm_curriculum 
    FOR EACH ROW BEGIN
			set @curriculumId = old.id//
			set @oprateType = (SELECT oprateType from user_data_change_records where status='0' and syncTarget=7 and objectId=@curriculumId)//	
			IF (@oprateType is NOT NULL) THEN 	
				set @objectId = (SELECT id from user_data_change_records where status='0' and syncTarget=7 and objectId=@curriculumId)//
				DELETE FROM user_data_change_records_detail where targetId =@objectId//
				DELETE FROM user_data_change_records where id = @objectId//
				IF (@oprateType ='1' || @oprateType ='2') THEN 	
					INSERT INTO user_data_change_records SET objectId=@curriculumId, oprateType = 2, ctime=NOW(),status='0',syncTarget=7,failCount=0//
				END IF//
			ELSE
				INSERT INTO user_data_change_records SET objectId=@curriculumId, oprateType = 2, ctime=NOW(),status='0',syncTarget=7,failCount=0//
			END IF//
END;
    
    
DROP TRIGGER IF EXISTS `tr_clazz_insert`;
CREATE TRIGGER `tr_clazz_insert` AFTER INSERT ON palm_clazz 
    FOR EACH ROW BEGIN
			INSERT INTO user_data_change_records SET objectId=new.id,oprateType = 0, ctime=NOW(),status='0',syncTarget=4,failCount=0//
			set @targetId = (select max(id) from user_data_change_records)//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='ID',propertyValue= new.id//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='NAME',propertyValue= new.clazzName//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='GRADE_ID',propertyValue= new.gradeId//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='CREATE_TIME',propertyValue= new.createTime//
			INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='UPDATE_TIME',propertyValue= new.updateTime//
END;


DROP TRIGGER IF EXISTS `tr_clazz_update`;
CREATE TRIGGER `tr_clazz_update` AFTER UPDATE ON palm_clazz 
    FOR EACH ROW BEGIN
			IF new.clazzName != old.clazzName OR old.gradeId != new.gradeId OR old.updateTime != new.updateTime THEN
				set @clazzId = new.id//
				set @objectId = (SELECT id from user_data_change_records where status='0' and syncTarget=4 and objectId=@clazzId)//	
				IF @objectId >0 THEN 	
					DELETE FROM user_data_change_records_detail where targetId =@objectId//
					set @targetId = @objectId//
				ELSE	
					INSERT INTO user_data_change_records SET objectId=new.id,oprateType = 1,ctime=NOW(),status='0',syncTarget=4,failCount=0//
					set @targetId = (select max(id) from user_data_change_records)//
				END IF//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='ID',propertyValue= new.id//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='NAME',propertyValue= new.clazzName//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='GRADE_ID',propertyValue= new.gradeId//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='CREATE_TIME',propertyValue= new.createTime//
				INSERT INTO user_data_change_records_detail SET targetId =@targetId,propertyName='UPDATE_TIME',propertyValue= new.updateTime//
			END IF//
END;
    
   
DROP TRIGGER IF EXISTS `tr_clazz_delete`;
CREATE TRIGGER `tr_clazz_delete` AFTER DELETE ON palm_clazz 
    FOR EACH ROW BEGIN
			set @clazzId = old.id//
			set @oprateType = (SELECT oprateType from user_data_change_records where status='0' and syncTarget=4 and objectId=@clazzId)//	
			IF (@oprateType is NOT NULL) THEN 	
				set @objectId = (SELECT id from user_data_change_records where status='0' and syncTarget=4 and objectId=@clazzId)//
				DELETE FROM user_data_change_records_detail where targetId =@objectId//
				DELETE FROM user_data_change_records where id = @objectId//
				IF (@oprateType ='1' || @oprateType ='2') THEN 	
					INSERT INTO user_data_change_records SET objectId=@clazzId, oprateType = 2, ctime=NOW(),status='0',syncTarget=4,failCount=0//
				END IF//
			ELSE
				INSERT INTO user_data_change_records SET objectId=@clazzId, oprateType = 2, ctime=NOW(),status='0',syncTarget=4,failCount=0//
			END IF//
END;