#功能一:完成用户登录
SET NAMES UTF8;
DROP DATABASE IF EXISTS xh_mobile;
CREATE DATABASE xh_mobile CHARSET=UTF8;
#1:创建用户登录表
USE xh_mobile;
CREATE TABLE xh_login(
  id INT PRIMARY KEY AUTO_INCREMENT,
  uname VARCHAR(50),
  upwd  VARCHAR(32)
);
#2:添加二条测试数据(合法帐户)
INSERT INTO xh_login VALUES(null,'lb',md5('171031'));
INSERT INTO xh_login VALUES(null,'lh',md5('171031'));

-- 评论列表
DROP TABLE IF EXISTS `xh_comment_list`;
CREATE TABLE `xh_comment_list` (
  `pid` int(11) NOT NULL,
  `title` varchar(64) DEFAULT NULL,
  `pic` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `xh_comment_list` (`pid`,`title`,`pic`) VALUES
(1,'有多少人知道，这些说唱歌手居然还隐藏着第二重身份','https://s2.ax1x.com/2020/01/18/1Squuj.jpg'),
(2,'派克特暂隐退中文说唱圈','https://s2.ax1x.com/2020/01/18/1SqKDs.jpg'),
(3,'这些潮牌都在打折','https://s2.ax1x.com/2020/01/18/1SqlEq.th.png'),
(4,'现在的Rapper已经拽到不想演就不演了？我觉得不行。','https://s2.ax1x.com/2020/01/18/1SqmvQ.jpg'),
(5,'审判结果出炉，不再是棋子的6ix9ine将作出何种选择？','https://s2.ax1x.com/2020/01/18/1SqdbR.jpg'),
(6,'火遍朋友圈的Know Know新歌抄袭了A妹？？','https://s2.ax1x.com/2020/01/18/1SqUKJ.jpg'),
(7,'Jony J瞧不起idol还要当《青春有你》的说唱导师？','https://s2.ax1x.com/2020/01/18/1SqBUx.jpg'),
(8,'我眼里的2019中国说唱十佳专辑','https://s2.ax1x.com/2020/01/18/1Sq0V1.jpg'),
(9,'当宋岳庭的《life’s a struggle》也遭到下架','https://s2.ax1x.com/2020/01/18/1Sqtv4.jpg'),
(10,'Jony J的一次忘词，或许成就了如今的鬼卞！','https://s2.ax1x.com/2020/01/18/1Sjswd.jpg'),
(11,'糟糕的2019终于快结束了。Drake：是吗我怎么没感觉？','https://s2.ax1x.com/2020/01/18/1SjreH.jpg'),
(12,'Bridge对阿姨们说：如果你的孩子喜欢说唱，希望你能支持他','https://s2.ax1x.com/2020/01/18/1SjyTA.jpg');

DROP TABLE IF EXISTS `xh_article_list`;
CREATE TABLE `xh_article_list` (
  `pid` int(11) NOT NULL,
  `title` varchar(64) DEFAULT NULL,
  `pic` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `xh_article_list` (`pid`,`title`,`pic`) VALUES
(1,'说唱音乐和HipHop文化，哪个更重要？','https://s2.ax1x.com/2020/01/19/1Coc8S.png'),
(2,'BBC为何公然抨击中国嘻哈文化？原来作者是港毒废青……','https://s2.ax1x.com/2020/01/19/1CofDs.th.png'),
(3,'为什么说这一年的说唱，才是真正来到了地上？','https://s2.ax1x.com/2020/01/19/1Co5Eq.th.png'),
(4,'BBC挑衅中国说唱歌手，马思唯挑战BBC','https://s2.ax1x.com/2020/01/19/1Coo5V.png'),
(5,'在舞台上风光的rapper背后，到底都隐藏着一群什么人？','https://s2.ax1x.com/2020/01/19/1CoH8U.png'),
(6,'一听Auto-Tune就跳脚，你真的听懂这首《天生我材必有用》了吗？','https://s2.ax1x.com/2020/01/19/1Coqv4.png'),
(7,'能把Wordplay玩到如此境界的，中文说唱或许只有他一人！','https://s2.ax1x.com/2020/01/19/1CojbR.th.png'),
(8,'JonyJ对蔡徐坤说：如果知道自己想要什么，别人怎么看你不重要','https://s2.ax1x.com/2020/01/19/1CTC8O.th.png'),
(9,'福克斯的演技，能hold住贾樟柯的电影吗？','https://s2.ax1x.com/2020/01/19/1CTArd.th.png'),
(10,'专访蛋堡/满人/Jnco：中文说唱早就有过黄金年代','https://s2.ax1x.com/2020/01/20/1Pd3cD.th.png');

-- 潮牌推荐
DROP TABLE IF EXISTS `xh_fashion_product`;
CREATE TABLE `xh_fashion_product` (
  `lid` int(11) NOT NULL,
  `title` varchar(64) DEFAULT NULL,
  `pic` varchar(128) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `xh_fashion_product`(`lid`,`title`,`pic`,`price`) VALUES
(1,'NOT TO EXCEED 春季工装牛仔裤男拼接口袋宽松直筒抽绳束脚收脚裤','https://s2.ax1x.com/2020/01/21/1F17fe.md.jpg','178'),
(2,'NUTTILY日系复古灯芯绒太空刺绣夹克男多口袋宽松翻领工装外套潮','https://s2.ax1x.com/2020/01/21/1F1bSH.md.jpg','598.00'),
(3,'NUTTILY 基础多色珊瑚绒情侣刺绣口袋拼接男士宽松圆领卫衣情侣','https://s2.ax1x.com/2020/01/21/1F1qld.md.jpg','298.00'),
(4,'NOT TO EXCEED 春季潮牌腰带束脚水洗牛仔裤潮流百搭复古休闲长裤','https://s2.ax1x.com/2020/01/21/1F1L6A.md.jpg','158.00'),
(5,'NUTTILY  日系复古潮牌简约宽松拼接休闲百搭舒适直筒灯芯绒裤男','https://s2.ax1x.com/2020/01/21/1F1OOI.md.jpg','190.00'),
(6,'NUTTILY日系复古原创设计水洗浅牛仔色长裤宽松阔腿垂感牛仔裤男','https://s2.ax1x.com/2020/01/21/1F1jmt.md.jpg','172.00'),
(7,'NOT TO EXCEED春季国潮新款复古洗水做旧直筒休闲长裤宽松牛仔裤','https://s2.ax1x.com/2020/01/21/1F1v0P.md.jpg','158.00'),
(8,'NOT TO EXCEED 春季2020新款纯色直筒牛仔裤男深蓝百搭男休闲长裤','https://s2.ax1x.com/2020/01/21/1F1xTf.md.jpg','158.00'),
(9,'NOT TO EXCEED 春季新款直筒宽松纯色牛仔裤男深蓝色经典休闲长裤','https://s2.ax1x.com/2020/01/21/1F3Sk8.md.jpg','158.00'),
(10,'NOT TO EXCEED 国潮2020双肩马甲包百搭实用个性小包街头战术背包','https://s2.ax1x.com/2020/01/21/1F3ptS.md.jpg','138.00');

-- 购物车
DROP TABLE IF EXISTS `xh_cart`;
CREATE TABLE `xh_cart` (
  `id`  INT PRIMARY KEY AUTO_INCREMENT,
  `lid` int(11) NOT NULL,
  `title` varchar(64) DEFAULT NULL,
  `pic` varchar(128) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `count` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
