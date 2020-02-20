<template>
  <div class="Login">
    <img src="../../../public/picture/title.png" alt="">
    <van-divider />
    <div class="form">
      <p>用户名:</p>
      <van-field placeholder="请输入用户名" v-model="uname"></van-field>
      <p>密码:</p>
      <van-field placeholder="请输入密码" v-model="upwd"></van-field>
      <van-button size="large" @click="login">登录</van-button>
      <label for="">快速登录</label>
      <div class="xh_social">
        <a href="javascript:;"><img src="../../../public/picture/icon_wb.png" alt=""></a>
        <a href="javascript:;"><img src="../../../public/picture/icon_QQ.png" alt=""></a>
      </div>
      <div  class="xh_regist">
        <span @click="regist">注册</span> 丨 <span>忘记密码</span>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data(){
    return{
      uname:"",
      upwd:""
    }
  },
  methods: {
    login(){
      // 1.创建正则表达式 字母数字3~12
      var reg=/^[a-zA-Z0-9]{2,12}$/
      // 2.获取用户名和密码
      var Uname = this.uname
      var Upwd = this.upwd
      // console.log(Uname,Upwd)
      // 3.验证用户名如果格式不正确
      //   提示格式错误
      if(!reg.test(Uname)){
        this.$dialog.alert({message: '用户名格式错误'});
        return;
      }
      // 4.验证密码如果格式不正确
      //   提示格式错误
      if(!reg.test(Upwd)){
        this.$dialog.alert({message: '密码错误'});
        return;
      }else{
      var url = "login";
      var obj = {uname:Uname,upwd:Upwd}
      console.log(obj)
      this.axios.get(url,{params:obj}).then(res=>{
        // console.log(res)
        console.log(res.data.code)
        if(res.data.code==1){
          this.$dialog.alert({message:'登录成功'})
          this.$router.push("/Home_page")
        }else{
          this.$dialog.alert({message:'登录失败'})
        }
      })
    }
    },
    regist(){
      this.$router.push("/Regist")
    }
  }
}
</script>
<style scoped>
  *{margin:0;padding:0;}
  p{
    margin:0;
    margin-bottom: 5px;
    font-weight: 1000;
    font-size:18px;
  }
  img{
    width:200px;
    height:80px;
    margin-left:25%;
    margin-top:10px;
  }
  .van-cell{
    border:1px solid #eee;
    border-radius:5px;
  }
  .form{
    margin-top:60px;
    box-sizing: border-box;
    padding:10px;
  }
  .van-button{
    background-color: #dc3024;
    color: #fff;
    font-size:18px;
    border-radius:3px;
    margin-top:30px;
    margin-bottom:5px;
  }
  label{
    font-weight: 700;
    font-size:18px;
    color:#999
  }
  .xh_social>a>img{
    width:32px;
    height:32px;
    margin-left:0;
    margin-right:10px;
  }
  .xh_regist{
    margin-top:50px;
    text-align: end;
  }
  .xh_regist>span{
    font-weight:500;
    color:#333;
    font-size:18px;
  }
</style>