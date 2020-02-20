<template>
  <div class="content">
    <!-- 顶部导航栏 -->
    <div class="top">
      <div class="t_pic">
        <img src="https://s2.ax1x.com/2020/01/20/1PzVYQ.png" alt="">
      </div>
      <div @click="Sea_user" class="user">
        <div v-if="session == 0">
          <img src="../../../public/picture/user.png" alt="">
        </div>
        <div v-else>
          <img src="../../../public/picture/user1.png" alt="">
        </div>
      </div>
    </div>
    <!-- 中间切换 -->
    
      <component v-bind:is="tab" @listenTochildEvent="showFromchild"></component>
    
    <!-- 页面底部 -->
    <div class="footer">
      <ul>
        <li>
          <a href="javascript:;">关于我们</a>
        </li>
        <li>
          <a href="javascript:;">在线留言</a>
        </li>
        <li>
          <a href="javascript:;">资助我们</a>
        </li>
      </ul>
    </div>
    <!-- 底部导航栏 -->
    <van-tabbar v-model="active">
      <van-tabbar-item @click="toggletab('Fpage')">
        <img slot="icon" src="../../../public/picture/page.png">
        首页
      </van-tabbar-item>
      <van-tabbar-item @click="toggletab('Article')">
        <img src="../../../public/picture/article.png" slot="icon">
        文章
      </van-tabbar-item>
      <van-tabbar-item @click="toggletab('Product')" >
        <img src="../../../public/picture/product.png" slot="icon">
        潮牌周边
      </van-tabbar-item>
      <van-tabbar-item @click="toggletab('Cart');mycart()" :info="info">
        <img slot="icon" src="../../../public/picture/cart.png">
        我的购物车
      </van-tabbar-item>
    </van-tabbar>
  </div>
</template>
<script>
import Fpage from '../../components/Fpage.vue'
import Article from '../../components/article.vue'
import Product from '../../components/Product.vue'
import Cart from '../../components/Cart.vue'

export default {
  components:{
    Fpage,
    Article,
    Product,
    Cart,
  },
  data() {
    return {
      active:0,
      tab:"Fpage",
      info:'',
      session:0
    }
  },
  created(){
    this.searSession()
  },
  methods:{
    //没有登录时不显示购物车的数量,也不能显示购物车物品
    //登录之后显示购物车数量
    searSession(){
      var url = "myinfo"
      this.axios.get(url).then(res=>{
        if(res.data.code == 1){
          console.log(1)
          var url = "searcart"
          this.axios.get(url).then(res=>{
            var arr = res.data
            var sum = 0;
            for(var p of arr){
              sum += p.count
            }
            this.$store.commit("addinfo",sum)
            this.info = this.$store.getters.getcount
          })
          this.session = 1
        }else{
          this.session = 0
        }
      })
    },
    Sea_user(){
      console.log(1)
      var url = "myinfo"
      this.axios.get(url).then(res=>{
        // console.log(res)
        if(res.data.code==-2){
          this.$toast('请登录')
          this.$router.push("/Login")
        }
      })
    },
    toggletab(tab){
      this.tab = tab;
    },
    mycart(){
      // console.log(1)
      var url = "myinfo"
      this.axios.get(url).then(res=>{
        if(res.data.code==-2){
          this.$toast('请登录')
          this.$router.push("/Login")
        }
      })
    },
    //接收子组件传过来的值
    showFromchild(data){
      console.log(data)
      this.info = data
    }
  }
}
</script>
<style scoped>
.content{
  background:#f6f6f6;
}
.van-nav-bar{
  height:48px;
  box-shadow: 10px;
}
.top{
  background:#fff;
  height:48px;
  display:flex;
}
.t_pic{
  margin-left:145.6px;
  margin-top:8px; 
}
.user{
  margin-left:110px;
  margin-top:12px;
}
.t_pic img{
  width:83.8px;
  height:32px;
}
.user img{
  width:24px;
  height:24px;
}
.footer{
  height:120px;
  background-color: #23282d;
  margin:20px 0 49.98px;
  text-align: center;
  box-sizing: border-box;
  padding:20px;
}
.footer li{
  text-decoration: none;
  list-style: none;
  margin-bottom:10px;
}
.footer a{
  color:#999;
  font-size:15px;
}
.wrapper {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
}
.block {
  width: 120px;
  height: 120px;
  background-color: #fff;
}
</style>


// 购物车思路：通过全局vuex 设置 cartcount 来保存全局的一个状态变量，通过点击添加购物车来改变
// cartcount的数量 再通过cartcount来改变info的变量
// 如果说没有登录的话就让info的值为空
