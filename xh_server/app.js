const express=require("express");
const session=require("express-session");
const mysql=require("mysql")
const cors=require("cors")
var pool=mysql.createPool({
  host:"127.0.0.1",
  user:"root",
  password:"",
  database:"xh_mobile",
  port:3306,
  connectionLimit:15
})
var server=express();
server.use(cors({
  origin:["http://127.0.0.1:8080","http://localhost:8080"],
  credentials:true
}))
//配置session对象
server.use(session({
  secret:"128位安全字符串",//加密条件
  resave:true,//请求数据
  saveUninitialized:true//保存初始数据  
}))
server.use(express.static("public"));
server.listen(2020);

server.get("/login",(req,res)=>{
  var u=req.query.uname;
  var p=req.query.upwd;
  console.log(u,p)
  var sql="select * from xh_login where uname=? and upwd=md5(?)";
  pool.query(sql,[u,p],(err,result)=>{
    if(err)throw err;
    console.log(result)
    if(result.length==0){
      res.send({code:-1,msg:"no"})
    }else{
      //将当前登录用户id保存
      //session对象中作为登陆成功凭证
      //获取当前用户id
      // console.log(result)
      var uid=result[0].id;
      //保存session对象中
      // console.log(req.session.id)
      req.session.uid=uid;
      console.log(req.session);
      res.send({code:1,msg:"yes"})
    }
  })
})
// 注册页面
server.get("/regist",(req,res)=>{
  var u=req.query.uname;
  var sql="select * from xh_login where uname=?"
  pool.query(sql,[u],(err,result)=>{
    console.log(result)
    if(result.length==0){
      res.send({code:1,msg:"yes"})
    }else{
      res.send({code:-1,msg:"no"})
    }
  })
})

server.get("/reguser",(req,res)=>{
  var u = req.query.uname;
  var p = req.query.upwd;
  var sql="insert into xh_login (uname,upwd) values(?,md5(?))"
  pool.query(sql,[u,p],(err,result)=>{
    if(err)throw err
    console.log(result)
    res.send({code:1})
    // 添加到session
    var uid=result.insertId;
      //保存session对象中
    req.session.uid=uid;
    console.log(req.session);
  })
})

// 查询xh_comment_list
server.get("/comment",(req,res)=>{
  var pno = req.query.pno;
  var ps = req.query.pagesize;
  // if(pno == 1){pno = 1}
  if(!ps){ps = 6}
  var offset = (pno-1)*ps;
  ps = parseInt(ps);
  var sql = "select * from xh_comment_list limit ?,?"
  pool.query(sql,[offset,ps],(err,result)=>{
    if(err)throw err;
    console.log(result)
    res.send(result)
  })
})

//myinfo:
//父组件加载时也调用此接口来显示购物车数量
server.get("/myinfo",(req,res)=>{
  // 1.获取用户登录凭证uid
  var uid = req.session.uid
  if(!uid){
    res.send({code:-2,msg:"请登录",data:[]});
  }else{
    res.send({code:1})
  }
})

//article_list
server.get("/article",(req,res)=>{
  var sql = "select * from xh_article_list";
  pool.query(sql,(err,result)=>{
    console.log(result)
    if(err)throw err;
    res.send(result);
  })
})

//查询商品列表
server.get("/product",(req,res)=>{
  var pno = req.query.pno
  var page = req.query.page
  if(!page){page = 6}
  var offset = (pno-1)*page
  var sql = "select * from xh_fashion_product limit ?,?";
  pool.query(sql,[offset,page],(err,result)=>{
    console.log(result)
    if(err)throw err
    res.send(result);
  })
})

//添加购物车
server.get("/addcart",(req,res)=>{
  //查询用户有没有登录，查看session缓存
  var uid = req.session.uid;
  if(!uid){
    res.send({code:-1,msg:'请登录'})
    return;
  }
  var pic = req.query.pic
  var lid = req.query.lid
  var title = req.query.title
  var price = req.query.price
  var sql = "select id from xh_cart where lid = ?"
  pool.query(sql,[lid],(err,result)=>{
    if(err)throw err
    if(result.length==0){
      var sql = `insert into xh_cart values(null,${lid},'${title}','${pic}',${price},1)`
    }else{
      var sql = `update xh_cart set count=count+1 where lid = ${lid}`
    }
    pool.query(sql,(err,result)=>{
      if(err)throw err
      res.send({code:1,msg:'添加成功'})
    })
  })
})

//查询购物车
//主页初始化时改变info也调用此接口(查询数据库购物车商品数量)
//购物车button按钮也调用此接口(查询数据库购物车商品数量)
server.get("/searcart",(req,res)=>{
  var sql = "select * from xh_cart";
  pool.query(sql,(err,result)=>{
    console.log(result)
    res.send(result)
  })
})

//点击修改购物车count
server.get("/updateCount",(req,res)=>{
  var lid = req.query.lid
  var count = req.query.count
  var sql = `update xh_cart set count = ${count} where lid = ${lid}`
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    console.log(result)
  })
})

// 删除数据
server.get("/delcart",(req,res)=>{
  var lid = req.query.lid;
  var sql = "delete from xh_cart where lid=?"
  pool.query(sql,[lid],(err,result)=>{
    if(err)throw err;
  })
})


