<template>
  <div>
    <div class="pic">
      <img src="../../public/picture/AB.jpg" alt="">
    </div>
    <!-- 文章主页 -->
    <div class="content">
      <div class="title">
        <h3>文章主页</h3>
      </div>
    </div>
    <div class="cPhoto">
      <img src="../../public/picture/centerphoto.jpg" alt="">
    </div>
    <!-- content-list -->
    <div class="content-list">
      <ul class="ajaxgets">
        <li class="ajaxget" v-for="(p,i) of list" :key="i"  @click="pageList(p.pid)">
          <img :src="p.pic" alt="">
          <h2><a href="javascript:;">{{p.title}}</a></h2>
        </li>
      </ul>
    </div>

  </div>
</template>
<script>
export default{
  data(){
    return{
      list:[],  
    }
  },
  created(){
    this.Loadmore()
  },
  methods:{
    Loadmore(){
      var url = "article"
      this.axios.get(url).then(res=>{
        console.log(res.data)
        this.list = res.data
      })
    },
    pageList(lid){
      console.log(lid)
    }
  },
}
</script>
<style scoped>
*{margin:0;padding:0;}
.pic{
  height:120px;
}
.pic img{
  width:375px;
  height:120px;
}
.content{
  background:#fff;
  box-sizing:border-box;
  padding:12px;
}
.content h3{
  font-size: 0.48rem;
  color: #333;
  font-weight: 400;
}
.cPhoto{
  text-align: center;
  margin-top:12px;
}
.cPhoto img{
  width:367.5px;
  height:45.94px;
}
.content-list{
  display:flex;
  justify-content: center;
}
.ajaxgets{
  width:368px;
  box-sizing:border-box;
  list-style:none;
  background:#fff;
  padding:8px;
  border-bottom: 1px #efefef solid;
}
.ajaxget{
  display:flex;
  box-sizing:border-box;
  padding:5px;
  border-bottom:1px solid #efefef;
}
.ajaxget>img{
  width:120px;
  height:70px;
  margin-right:10px;
}
a{
  display:inline-block;
  color: #333;
  font-size:16px;
}
</style>