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
  name varchar(255) DEFAULT NULL,
  subTitle varchar(255) DEFAULT NULL,
  originalPrice float DEFAULT NULL,
  promotePrice float DEFAULT NULL,
  stock int(11) DEFAULT NULL,
  cid int(11) DEFAULT NULL,
  createDate datetime DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_product_category FOREIGN KEY (cid) REFERENCES category (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- 属性值表   	存放属性值信息，如重量是900g,颜色是粉红色
CREATE TABLE propertyvalue (
  id int(11) NOT NULL AUTO_INCREMENT,
  pid int(11) DEFAULT NULL,
  ptid int(11) DEFAULT NULL,
  value varchar(255) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_propertyvalue_property FOREIGN KEY (ptid) REFERENCES property (id),
  CONSTRAINT fk_propertyvalue_product FOREIGN KEY (pid) REFERENCES product (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- 产品图片表    存放产品图片信息，如产品页显示的5个图片
CREATE TABLE productimage (
  id int(11) NOT NULL AUTO_INCREMENT,
  pid int(11) DEFAULT NULL,
  type varchar(255) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_productimage_product FOREIGN KEY (pid) REFERENCES product (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 评价表    存放评论信息，如买回来的蜡烛很好用，么么哒
CREATE TABLE review (
  id int(11) NOT NULL AUTO_INCREMENT,
  content varchar(4000) DEFAULT NULL,
  uid int(11) DEFAULT NULL,
  pid int(11) DEFAULT NULL,
  createDate datetime DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_review_product FOREIGN KEY (pid) REFERENCES product (id),
    CONSTRAINT fk_review_user FOREIGN KEY (uid) REFERENCES user (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- 订单表    存放订单信息，包括邮寄地址，电话号码等信息
CREATE TABLE order_ (
  id int(11) NOT NULL AUTO_INCREMENT,
  orderCode varchar(255) DEFAULT NULL,
  address varchar(255) DEFAULT NULL,
  post varchar(255) DEFAULT NULL,
  receiver varchar(255) DEFAULT NULL,
  mobile varchar(255) DEFAULT NULL,
  userMessage varchar(255) DEFAULT NULL,
  createDate datetime DEFAULT NULL,
  payDate datetime DEFAULT NULL,
  deliveryDate datetime DEFAULT NULL,
  confirmDate datetime DEFAULT NULL,
  uid int(11) DEFAULT NULL,
  status varchar(255) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_order_user FOREIGN KEY (uid) REFERENCES user (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- 订单项表   存放订单项信息，包括购买产品种类，数量等
CREATE TABLE orderitem (
  id int(11) NOT NULL AUTO_INCREMENT,
  pid int(11) DEFAULT NULL,
  oid int(11) DEFAULT NULL,
  uid int(11) DEFAULT NULL,
  number int(11) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_orderitem_user FOREIGN KEY (uid) REFERENCES user (id),
  CONSTRAINT fk_orderitem_product FOREIGN KEY (pid) REFERENCES product (id),
  CONSTRAINT fk_orderitem_order FOREIGN KEY (oid) REFERENCES order_ (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;