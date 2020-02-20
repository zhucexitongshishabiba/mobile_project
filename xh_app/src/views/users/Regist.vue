<template>
  <div class="regist">
    <img src="../../../public/picture/title.png" alt="">
    <van-divider />
    <div class="reg-list">
      <div class="title">注册</div>
      <p>用户名:</p>
      <van-field placeholder="请输入用户名" v-model="uname"></van-field>
      <p>密码:</p>
      <van-field placeholder="请输入密码" v-model="upwd"></van-field>
      <p>确认密码:</p>
      <van-field placeholder="请再次输入密码" v-model="upwds"></van-field>
      <van-button size="large" @click="regist">注册</van-button>
      <label for="">快速登录</label>
      <div class="xh_social">
        <a href="javascript:;"><img src="../../../public/picture/icon_wb.png" alt=""></a>
        <a href="javascript:;"><img src="../../../public/picture/icon_QQ.png" alt=""></a>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data(){
    return{
      uname:"",
      upwd:"",
      upwds:""
    }
  },
  methods:{
    regist(){
      // 正则
      var reg = /^[a-zA-Z0-9]{2,12}$/
      // 获取输入框的值
      var Uname = this.uname
      var Upwd = this.upwd
      var Upwds = this.upwds
      // 进行正则判断
      if(!reg.test(Uname)){
        this.$dialog.alert({message: '用户名格式错误'});
        return;
      }else{
        var url = "regist";
        var obj = {uname:Uname}
        this.axios.get(url,{params:obj}).then(res=>{
          console.log(res.data.code)
          if(res.data.code==-1){
            this.$dialog.alert({message:'用户名已存在'})
          }else{
            if(!reg.test(Upwd)){
              this.$dialog.alert({message: '密码格式错误'});
              return;
            }
            if(!reg.test(Upwds)||Upwd!==Upwds){
              this.$dialog.alert({message: '确认密码有误'});
              return;
            }
            var url = "reguser"
            var obj = {uname:Uname,upwd:Upwd}
            this.axios.get(url,{params:obj}).then(res=>{
              console.log(res.data.code)
              if(res.data.code==1){
                this.$router.push("/Home_page")
              }
            })
          }
        })
      }
    }
  },

}

</script>
<style scoped>
  img{
    width:200px;
    height:80px;
    margin-left:25%;
    margin-top:10px;
  }
  .regist{
    background:#f5f5f5;
    height:667px;
  }
  .title{
    text-align: center;
    font-size:25px;
  }
  .reg-list{
    background:#fff;
    width:80%;
    margin:0 auto;
    border: 1px solid #eee;
    padding: 40px 25px;
  }
  .van-field{
    width: 100%;
    height: 35px;
    padding: 6px 12px;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 3px;
    box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
  }
  p{
    margin-bottom: 5px;
    font-weight: 700;
  }
  .van-button{
    color: #fff;
    background-color: #009a61;
    border-color: #008151;
    font-size:18px;
    border-radius:3px;
    margin-top:30px;
    margin-bottom:5px;
  }
  .xh_social>a>img{
    width:32px;
    height:32px;
    margin-left:0;
    margin-right:10px;
  }
</style>