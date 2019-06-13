SET NAMES UTF8;
DROP DATABASE IF EXISTS foods;
CREATE DATABASE foods CHARSET=UTF8;
USE foods;
/*创建首页轮播表*/
CREATE TABLE food_index_banner(
  bid INT PRIMARY KEY AUTO_INCREMENT,
  img_url VARCHAR(255)
);
INSERT INTO food_index_banner VALUES(NULL,'img/index/banner1.jpg');
INSERT INTO food_index_banner VALUES(NULL,'img/index/banner2.jpg');
INSERT INTO food_index_banner VALUES(NULL,'img/index/banner3.jpg');
INSERT INTO food_index_banner VALUES(NULL,'img/index/banner4.jpg');
INSERT INTO food_index_banner VALUES(NULL,'img/index/banner5.jpg');

/*创建首页九宫格表*/
CREATE TABLE food_index_grid(
  gid INT PRIMARY KEY AUTO_INCREMENT,
  img_url VARCHAR(255),
  tit VARCHAR(255),
  href VARCHAR(255)
);
INSERT INTO food_index_grid VALUES(NULL,'img/index/icon_1.png','购物车','shopCar');
INSERT INTO food_index_grid VALUES(NULL,'img/index/icon_2.png','菜品列表','shopList');
INSERT INTO food_index_grid VALUES(NULL,'img/index/icon_3.png','留言板','message');

/*创建首页精选表*/
CREATE TABLE food_index_nice(
  nid INT PRIMARY KEY AUTO_INCREMENT,
  tit VARCHAR(255),
  img_a VARCHAR(255),
  img_b VARCHAR(255),
  img_c VARCHAR(255),
  img_d VARCHAR(255),
  href VARCHAR(255),
  span VARCHAR(255)
);
INSERT INTO food_index_nice VALUES(NULL,'夏日必备的下酒菜,老外见了都爱吃！','img/index/jx1.jpg','img/index/jx2.jpg','img/index/jx3.jpg','img/index/jx4.jpg','/','菜谱');
INSERT INTO food_index_nice VALUES(NULL,'培根金针菇卷:诱人食欲，味道太赞了','img/index/jx5.jpg','img/index/jx6.jpg','img/index/jx7.jpg','img/index/jx8.jpg','/','专题');
INSERT INTO food_index_nice VALUES(NULL,'只有大口吃肉,才是心灵上的满足','img/index/jx13.jpg','img/index/jx14.jpg','img/index/jx15.jpg','img/index/jx16.jpg','/','菜单');

CREATE TABLE food_index_recommend(
  rid INT PRIMARY KEY AUTO_INCREMENT,
  tit VARCHAR(255),
  img_url VARCHAR(255),
  href VARCHAR(255),
  span_a VARCHAR(255),
  span_b VARCHAR(255)
);
INSERT INTO food_index_recommend VALUES(NULL,'鸭蛋西兰花面疙瘩','img/index/tj1.jpg','#','西兰花、面粉、鸭蛋、酱油、盐、味精','菜谱');
INSERT INTO food_index_recommend VALUES(NULL,'红薯雪梨糖水','img/index/tj2.jpg','#','红薯、雪梨、枸杞、清水、冰糖','菜谱');
INSERT INTO food_index_recommend VALUES(NULL,'耗油杏鲍菇','img/index/tj3.jpg','#','杏鲍菇、耗油、葱、姜、蒜','菜谱');
INSERT INTO food_index_recommend VALUES(NULL,'西兰花炒木耳','img/index/tj4.jpg','#','西兰花、木耳、胡萝卜、香肠、葱、姜、蒜。','菜谱');
INSERT INTO food_index_recommend VALUES(NULL,'青椒炒山药','img/index/tj5.jpg','#','青椒、胡萝卜、山药、油、盐、酱油、鸡精。','菜谱');
INSERT INTO food_index_recommend VALUES(NULL,'酸奶蛋糕','img/index/tj6.jpg','#','酸奶、油、低筋粉、鸡蛋、糖。','菜谱');

/*创建登录注册表*/
CREATE TABLE food_reg(
  id INT PRIMARY KEY AUTO_INCREMENT,
  phone VARCHAR(255),
  pwd VARCHAR(255),
  uname VARCHAR(255)
);
INSERT INTO food_reg VALUES(NULL,18439029321,md5('LL1234'),'dingding');
INSERT INTO food_reg VALUES(NULL,18439029322,md5('LL1234'),'lingling');
INSERT INTO food_reg VALUES(NULL,18439029323,md5('LL1234'),'dingdang');
INSERT INTO food_reg VALUES(NULL,18439029324,md5('LL1234'),'lingdang');

/*创建商品详情表*/
CREATE TABLE food_details(
  id INT PRIMARY KEY AUTO_INCREMENT,
  pid INT,
  tit VARCHAR(255),
  img_url VARCHAR(255),
  i_a INT,
  span_a VARCHAR(255),
  span_b VARCHAR(255),
  span_c VARCHAR(255),
  price VARCHAR(255)
);
INSERT INTO food_details VALUES(NULL,1,'酱蒸五花肉','img/details/d1.jpg',226,'给五花肉换个做法，量合适就行，用蒸的方式，好吃不上火。没想到这样做的五花肉上桌就被抢光，汤汁都用来浇米饭拌着吃，真正的汤...','五花肉300克、黄酱30克、生抽4克','大蒜3克、香菜少许、糖2克、耗油5克、姜片4片、水10克','34.00');
INSERT INTO food_details VALUES(NULL,2,'奶香土豆泥','img/details/d2.jpg',202,'好吃的土豆泥口感一定是很细腻的，所以我是将土豆去皮后切小块蒸熟再加入调味，自己做的用的都是新鲜土豆，口感上就比洋快餐店的...','土豆250克、牛奶40克、精盐1克','黄油15克、黑胡椒粉1小勺、淡奶油10克','18.00');
INSERT INTO food_details VALUES(NULL,3,'清蒸虾丸','img/details/d3.jpg',202,'学龄儿童的黄金菜单，喷香营养，补钙好消化，孩子爱吃个儿高，你也赶紧试试吧~','胡萝卜适量、虾400克、橄榄油10克','酱油10克、盐1克、胡椒粉1克、料酒3克、姜粉1克、淀粉10克','30.00');
INSERT INTO food_details VALUES(NULL,4,'花开富贵卷','img/details/d4.jpg',180,'叫它花开富贵卷,卖相十分的赏心悦目，做法也不难，主料是牛肉，胡萝卜和豆腐皮，荤素搭配营养...','豆腐皮1张、牛肉100克、胡萝卜半根','淀粉2勺、料酒1小勺、鸡蛋1个、盐适量、胡椒粉2克、酱油2勺、蒜末适量、香葱辣椒适量','28.00');
INSERT INTO food_details VALUES(NULL,5,'粉丝蒸贵妃螺','img/details/d5.jpg',180,'最喜欢这样蒸螺，鲜美下饭','贵妃螺8个、粉丝30克、蒜半头','指天椒2个、蒸鱼豉油20克、食用油2勺','58.00');
INSERT INTO food_details VALUES(NULL,6,'红豆薏米粥','img/details/d6.jpg',180,'食美粥-美容粥系列|“红豆薏米粥”美容抗衰 红豆薏仁粥 红豆薏米水祛湿利尿 营养早餐,红豆、薏米都是非常祛湿利尿，对于水肿有...','红豆100克、薏米50克','冰水适量、清水1000毫升','5.00');
INSERT INTO food_details VALUES(NULL,7,'白菜豆腐汤','img/details/d7.jpg',300,'无','葱段5克、豆腐250克、白菜200克','食用油5毫升、胡椒粉5克、老抽3毫升、清水300毫升、十三香2克、盐3克、白胡椒3克','5.00');
INSERT INTO food_details VALUES(NULL,8,'鱼香茄条','img/details/d8.jpg',300,'无','茄子适量','葱花适量、水淀粉适量、生抽适量、醋适量、糖适量、葱适量、蒜适量、姜适量、小米辣适量','15.00');

/*创建购物车表*/
CREATE TABLE food_shopCar(
  id INT PRIMARY KEY AUTO_INCREMENT,
  img_url VARCHAR(255),
  tit VARCHAR(25),
  price DECIMAL(10,2),
  count INT,
  pid INT,
  uid INT
);
INSERT INTO food_shopCar VALUES(NULL,'img/details/d1.jpg','酱蒸五花肉','34.00',1,1,1);
INSERT INTO food_shopCar VALUES(NULL,'img/details/d2.jpg','奶香土豆泥','18.00',1,2,2);
INSERT INTO food_shopCar VALUES(NULL,'img/details/d2.jpg','奶香土豆泥','18.00',1,2,3);
INSERT INTO food_shopCar VALUES(NULL,'img/details/d2.jpg','奶香土豆泥','18.00',1,2,1);
INSERT INTO food_shopCar VALUES(NULL,'img/details/d3.jpg','清蒸虾丸','30.00',1,3,4);
INSERT INTO food_shopCar VALUES(NULL,'img/details/d3.jpg','清蒸虾丸','30.00',1,3,1);
INSERT INTO food_shopCar VALUES(NULL,'img/details/d4.jpg','花开富贵卷','28.00',1,4,2);
INSERT INTO food_shopCar VALUES(NULL,'img/details/d4.jpg','花开富贵卷','28.00',1,4,1);

/*创建留言板输入表*/
CREATE TABLE food_message(
  id INT PRIMARY KEY AUTO_INCREMENT,
  txt VARCHAR(255),
  sj VARCHAR(255),
  uname VARCHAR(255)
);