<template>
  <div>
    <!-- 下拉刷新 -->
    <van-pull-refresh
      v-model="isLoading"
      @refresh="onRefresh"
    >
      <!-- 轮播图 -->
      <div class="swipe">
        <van-swipe :autoplay="3000" indicator-color="white">
          <van-swipe-item>
            <img class="banner" src="../../public/picture/banner1.jpg" alt="">
          </van-swipe-item>
          <van-swipe-item>
            <img class="banner" src="../../public/picture/banner2.jpg" alt="">
          </van-swipe-item>
          <van-swipe-item>
            <img class="banner" src="../../public/picture/banner3.jpg" alt="">
          </van-swipe-item>
          <van-swipe-item>
            <img class="banner" src="../../public/picture/banner4.jpg" alt="">
          </van-swipe-item>
        </van-swipe>
      </div>
  <!-- 推荐标题 -->
      <div class="content">
        <div class="title">
          <h3>精彩推荐</h3>
        </div>
      </div>
    <!-- 推荐图片 -->
      <div class="recommend">
        <div class="thumb">
          <div>
            <img src="../../public/picture/recommend1.png" alt="">
          </div>
          <div>
            <img src="../../public/picture/recommend2.jpg" alt="">
          </div>
          <div>
            <img src="../../public/picture/recommend3.jpg" alt="">
          </div>
          <div>
            <img src="../../public/picture/recommend4.jpg" alt="">
          </div>
        </div>
      </div>
  <!-- 最新文章 -->
      <div class="content">
        <div class="title">
          <h3>最新文章</h3>
        </div>
      </div>
      <!-- 文章列表 -->
      <div class="article">
        <ul class="axiosgets">
          <li class="axiosget" v-for="(p,i) of list" :key="i">
            <img :src="p.pic" alt="">
            <h2><a href="javascript:;">{{p.title}}</a></h2>
          </li>
        </ul>
      </div>
    </van-pull-refresh>
    
    <div class="more">
      <a href="javascript:;" @click="onLoad">加载更多</a>
    </div>
  </div>
</template>
<script>
export default{
  data(){
    return{
      list:[],
      pno:1,
      isLoading: false,//下拉刷新
    }
  },
  mounted(){
    this.Loadmore();
    console.log(1)
  },
  methods:{
    Loadmore(){
      this.pno = 1;
      var url = "/comment";
      var obj = {pno:this.pno}
      this.axios.get(url,{params:obj}).then(res=>{
        console.log(res.data)
        this.list = res.data
      })
    },//Loadmore1
    onRefresh() { // 下拉调用此函数
        setTimeout(() => {
          this.$toast('刷新成功');  //弹出
          this.isLoading = false;
          this.Loadmore();
        }, 500);
    },//onRefresh
    onLoad() { // 上拉调用此函数
      this.pno++
      // console.log(this.pno)
      if(this.pno<=2){
        console.log(1)
        setTimeout(() => {
          this.$toast('加载成功');//弹出
          this.isUpLoading = false;
          var url = "comment";
          var obj = {pno:this.pno}
          this.axios.get(url,{params:obj}).then(res=>{
            console.log(res.data)
            this.list = this.list.concat(res.data);
          })
        }, 500);
      }else{this.$toast('人家是有底线的!!!')}
    },//onload
  },
}
</script>
<style scoped>
*{margin:0;padding:0;}
.swipe{
  display:flex;
  justify-content: center;
  margin-top:10px;
}
.van-swipe{
  width:368px;
}
.banner{
  width:368px;
}
.content{
  display:flex;
  justify-content: center;
}
.title{
  width:368px;
  box-sizing:border-box;
  padding:8px;
  background:#fff;
  margin-top:10px;
  border-bottom: 1px #efefef solid;
  
}
.title>h3{
  font-size: 18px;
  color: #333;
  font-weight:400;
}
.recommend{
  display:flex;
  justify-content: center;
  margin-bottom:5px;
}
.thumb>div>img{
  width:171.75px;
}
.thumb{
  width:368px;
  display:flex;
  flex-wrap: wrap;
  justify-content: center;
  box-sizing:border-box;
  background:#fff;
}
.thumb>div{
  padding:3px;
}
.article{
  display:flex;
  justify-content: center;
}
.axiosgets{
  width:368px;
  box-sizing:border-box;
  list-style:none;
  background:#fff;
  padding:8px;
  border-bottom: 1px #efefef solid;
}
.axiosget{
  display:flex;
  box-sizing:border-box;
  padding:5px;
  border-bottom:1px solid #efefef;
}
.axiosget>img{
  width:120px;
  height:70px;
  margin-right:10px;
}
a{
  display:inline-block;
  color: #333;
  font-size:16px;
}
.more{
  background:#fff;
  width:367px;
  box-sizing:border-box;
  padding:8px;
  display:flex;
  justify-content: center;
  margin-left:4px;
  height:60px;
}
.more a{
  line-height:44px;
}
</style>