DROP DATABASE IF EXISTS tmall_ssm;
CREATE DATABASE tmall_ssm DEFAULT CHARACTER SET utf8;
USE tmall_ssm;

-- 用户表    存放用户信息，如斩手狗，千手小粉红
CREATE TABLE user (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(255) DEFAULT NULL,
  password varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 分类表    	存放分类信息，如女装，平板电视，沙发等
CREATE TABLE category (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- 属性表    存放属性信息，如颜色，重量，品牌，厂商，型号等
CREATE TABLE property (
  id int(11) NOT NULL AUTO_INCREMENT,
  cid int(11) DEFAULT NULL,
  name varchar(255) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_property_category FOREIGN KEY (cid) REFERENCES category (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 产品表    存放产品信息，如LED40EC平板电视机，海尔EC6005热水器
CREATE TABLE product (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(255) DEFAULT NULL COMMENT '产品名称',
  subTitle varchar(255) DEFAULT NULL COMMENT '小标题',
  originalPrice float DEFAULT NULL COMMENT '原始价格',
  promotePrice float DEFAULT NULL COMMENT '优惠价格',
  stock int(11) DEFAULT NULL COMMENT '库存',
  cid int(11) DEFAULT NULL COMMENT '外键 指向分类表的id字段',
  createDate datetime DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (id),
  CONSTRAINT fk_product_category FOREIGN KEY (cid) REFERENCES category (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- 属性值表   	存放属性值信息，如重量是900g,颜色是粉红色
CREATE TABLE propertyvalue (
  id int(11) NOT NULL AUTO_INCREMENT,
  pid int(11) DEFAULT NULL COMMENT '指向产品表的id字段',
  ptid int(11) DEFAULT NULL COMMENT '指向属性表的id字段',
  value varchar(255) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_propertyvalue_property FOREIGN KEY (ptid) REFERENCES property (id),
  CONSTRAINT fk_propertyvalue_product FOREIGN KEY (pid) REFERENCES product (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- 产品图片表    存放产品图片信息，如产品页显示的5个图片
CREATE TABLE productimage (
  id int(11) NOT NULL AUTO_INCREMENT,
  pid int(11) DEFAULT NULL COMMENT '外键pid 指向产品表的id字段',
  type varchar(255) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_productimage_product FOREIGN KEY (pid) REFERENCES product (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 评价表    存放评论信息，如买回来的蜡烛很好用，么么哒
CREATE TABLE review (
  id int(11) NOT NULL AUTO_INCREMENT,
  content varchar(4000) DEFAULT NULL,
  uid int(11) DEFAULT NULL COMMENT '指向用户表的id字段',
  pid int(11) DEFAULT NULL COMMENT '指向产品表的id字段',
  createDate datetime DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_review_product FOREIGN KEY (pid) REFERENCES product (id),
    CONSTRAINT fk_review_user FOREIGN KEY (uid) REFERENCES user (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- 订单表    存放订单信息，包括邮寄地址，电话号码等信息
CREATE TABLE order_ (
  id int(11) NOT NULL AUTO_INCREMENT,
  orderCode varchar(255) DEFAULT NULL COMMENT '订单号',
  address varchar(255) DEFAULT NULL COMMENT '收货地址',
  post varchar(255) DEFAULT NULL COMMENT '邮编',
  receiver varchar(255) DEFAULT NULL COMMENT '收货人信息',
  mobile varchar(255) DEFAULT NULL COMMENT '手机号码',
  userMessage varchar(255) DEFAULT NULL COMMENT '用户备注信息',
  createDate datetime DEFAULT NULL COMMENT '订单创建日期',
  payDate datetime DEFAULT NULL COMMENT '支付日期',
  deliveryDate datetime DEFAULT NULL COMMENT '发货日期',
  confirmDate datetime DEFAULT NULL COMMENT '确认收货日期',
  uid int(11) DEFAULT NULL  COMMENT '外键uid 指向用户表id字段',
  status varchar(255) DEFAULT NULL COMMENT '订单状态',
  PRIMARY KEY (id),
  CONSTRAINT fk_order_user FOREIGN KEY (uid) REFERENCES user (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- 订单项表   存放订单项信息，包括购买产品种类，数量等
CREATE TABLE orderitem (
  id int(11) NOT NULL AUTO_INCREMENT,
  pid int(11) DEFAULT NULL COMMENT '外键pid, 指向产品表id字段',
  oid int(11) DEFAULT NULL COMMENT '外键oid 指向订单表id字段',
  uid int(11) DEFAULT NULL COMMENT '指向用户表id字段',
  number int(11) DEFAULT NULL COMMENT '购买数量',
  PRIMARY KEY (id),
  CONSTRAINT fk_orderitem_user FOREIGN KEY (uid) REFERENCES user (id),
  CONSTRAINT fk_orderitem_product FOREIGN KEY (pid) REFERENCES product (id),
  CONSTRAINT fk_orderitem_order FOREIGN KEY (oid) REFERENCES order_ (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;