//vue_server_00/app.js
//1:复制服务器端模块
//2:引入第三方模块
//  mysql/express/
const mysql = require("mysql");
const express = require("express");
//2.1 引入express-session组件
const session=require("express-session");

//3:创建连接池
const pool = mysql.createPool({
  host:"127.0.0.1",
  user:"root",
  password:"",
  database:"foods"
});
//4:创建express对象
var server = express(); 

//4.1 配置session
server.use(session({
  secret:"128位字符串",      //配置密钥
  resave:true,             //每次请求是否更新数据
  saveUninitialized:true    //保存初始化数据
}))

//app.js 录一段跨域配置
const cors = require("cors");
server.use(cors({
   origin:["http://127.0.0.1:8080",
   "http://localhost:8080"],
   credentials:true
}))

//5:绑定监听端口 3000
server.listen(3000);
//5.1:指定静态目录.保存图片资源
//    项目中所有图片都需要保存在服务器端
//    重启动服务器 
server.use(express.static("public"));

//1.查询首页轮播表
server.get("/imglist",(req,res)=>{
  var sql="SELECT img_url FROM food_index_banner"
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    res.send(result);
  })
})
//2.查询首页九宫格表
server.get("/imggrid",(req,res)=>{
  var sql="SELECT gid,img_url,tit,href FROM food_index_grid"
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    res.send(result);
  })
})
//3.查询首页精选表
server.get("/jxImg",(req,res)=>{
  var sql="SELECT * FROM food_index_nice"
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    res.send(result);
  })
})
//4.查询首页推荐列表
server.get("/recommend",(req,res)=>{
  var pno=req.query.pno;
  var pageSize=req.query.pageSize;
  //为参数设置默认值
  if(!pno){pno=1}
  if(!pageSize){pageSize=2}
  //创建变量保存发送给客户端数据
  var obj={code:1};
  var progress=0;
  var sql="SELECT rid,tit,img_url,href,span_a,span_b FROM food_index_recommend LIMIT ?,?"
  //创建一个变量offset 起始行数
  //创建一个变量ps 一页数据
  var offset=(pno-1)*pageSize;
  var ps= parseInt(pageSize);
  pool.query(sql,[offset,ps],(err,result)=>{
    if(err) throw err;
    progress+=50;
    obj.data=result;
    if(progress==100){
      res.send(obj);
    }
  })
  //计算总页数
  var sql="SELECT count(rid) AS c FROM";
      sql+=" food_index_recommend";
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    progress+=50;
    var pc=Math.ceil(result[0].c/pageSize)+1;
    obj.pageCount=pc;
    if(progress==100){
      res.send(obj);
    }
  })
})
//5.注册
server.get("/reg",(req,res)=>{
  var $phone=req.query.phone;
  var $pwd=req.query.pwd;
  var $uname=req.query.uname;
  var sql="INSERT INTO food_reg(phone,pwd,uname) VALUES";
  sql+="(?,md5(?),?)";
  pool.query(sql,[$phone,$pwd,$uname],(err,result)=>{
    if(err) throw err;
    if(result.affectedRows>0){
      res.send({code:1,msg:"注册成功"});
    }
  })
})
//6.登陆
server.get("/login",(req,res)=>{
  var phone=req.query.phone;
  var pwd=req.query.pwd;
  var sql="SELECT id,phone,pwd,uname FROM food_reg"
  sql+=" WHERE phone=? AND pwd=md5(?)";
  pool.query(sql,[phone,pwd],(err,result)=>{
    if(err) throw err;
    if(result.length==0){
      res.send({code:-1,msg:"手机号或者密码错误"});
    }else{
      var id=result[0].id;
      var uname=result[0].uname;
      //保存到session对象中
      req.session.uid=id;
      req.session.uname=uname;
      res.send({code:1,msg:"登陆成功"});
    }
  })
})
//获取session中uname
server.get("/getInfo",(req,res)=>{
  var uname=req.session.uname;
  res.send(uname);
})
//7.菜品列表
server.get("/shopList",(req,res)=>{
  var sql="SELECT id,img_url,tit,price FROM food_details";
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    res.send(result);
  })
})
//8.菜品详情
server.get("/details",(req,res)=>{
  var sql="SELECT * FROM food_details"
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    res.send({code:1,data:result});
  })
})
//9.查询购物车列表
server.get("/getCar",(req,res)=>{
  var uid=req.session.uid;
  if(!uid){
    res.send({code:-1,msg:"请登录",data:[]});
    return;
  }
  var sql="SELECT id,img_url,tit,price,count";
  sql+=" FROM food_shopCar";
  sql+=" WHERE uid=?"
  pool.query(sql,[uid],(err,result)=>{
    if(err) throw err;
    res.send({code:1,data:result});
  })
})
//10.删除购物车选中项
server.get("/delM",(req,res)=>{
  var ids=req.query.ids;
  var sql="DELETE FROM food_shopCar WHERE id IN ("+ids+")";
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    if(result.affectedRows==0){
      res.send({code:-1,msg:"删除失败"});
    }else{
      res.send({code:1,msg:"删除成功"});
    }
  })
})
//11.购物车中添加商品
server.get("/addCar",(req,res)=>{
  var pid=parseInt(req.query.pid);
  var uid=req.session.uid;
  var tit=req.query.tit;
  var price=req.query.price;
  var count=req.query.count;
  var img_url=req.query.img_url;
  var sql =" SELECT pid FROM food_shopCar";
      sql+=" WHERE uid=? AND pid=?";
  pool.query(sql,[uid,pid],(err,result)=>{
    if(err) throw err;
    if(result.length==0){
      var sql=`INSERT INTO food_shopCar VALUES(NULL,"${img_url}","${tit}",${price},${count},${pid},${uid}`;
    }else{
      var sql =` UPDATE food_shopCar`;
          sql+=` SET count=count+${count}`;
          sql+=` WHERE pid=${pid}`;
          sql+=` AND uid=${uid}`;
    }
    pool.query(sql,(err,result)=>{
      if(err) throw err;
      if(result.affectedRows>0){
        res.send({code:1,msg:"添加成功"});
      }else{
        res.send({code:-1,msg:"添加失败"});
      }
    })
  })
})
//12.用户退出
server.get("/goOut",(req,res)=>{
  req.session.uid="";
  req.session.uname="";
  res.send({code:1,msg:"退出成功"});
})
//13.向留言板表中添加内容
server.get("/report",(req,res)=>{
  var uname=req.session.uname;
  var txt=req.query.text;
  var time=req.query.sj;
  var sql="INSERT INTO food_message VALUES(NULL,?,?,?)";
  pool.query(sql,[txt,time,uname],(err,result)=>{
    if(err) throw err;
    if(result.affectedRows>0){
      //14.查询留言板表
      var sql="SELECT id,sj,txt,uname FROM food_message ORDER BY id desc";
      pool.query(sql,(err,result)=>{
        if(err) throw err;
        res.send(result);
      })
    }else{
      res.send({code:-1,msg:"发布失败"})
    }
  })
})