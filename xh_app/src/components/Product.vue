<template>
  <div>
    <div class="Ptitle">
      <img src="../../public/picture/Ptitle.jpg" alt="">
    </div>
    <div class="content">
      <div class="head">
        <h3>潮牌大全</h3>
      </div>
    </div>
    <!-- 商品列表 -->
    <div class="products">
      <div v-for="(p,i) of list" :key='i'>
        <img :src="p.pic" alt="">
        <h5>{{p.title}}</h5>
        <h4>¥{{p.price.toFixed(2)}}</h4>
        <van-button
        color="linear-gradient(to right, #FFD700, #FF7D40)"
        @click="addcart(p.lid,p.title,p.price,p.pic);sendToparent()">
        加入购物车
        </van-button>
      </div>
    </div>
    <!-- 加载更多 -->
    <div class="more">
      <van-button @click="more">加载更多</van-button>
    </div>
  </div>
</template>
<script>
export default{
  data(){
    return{
      list:[],
      pno:1,
    }
  },
  created(){
    this.Loadmore()
  },
  // mounted(){
  //   this.$axios.all([this.addcart()])
  //   .then(this.$axios.spread(function(){
  //     console.log(123)
  //   }))
  // },
  methods:{
    Loadmore(){
      this.pno = 1;
      var url = "product";
      var obj = {pno:this.pno}
      this.axios.get(url,{params:obj}).then(res=>{
        // console.log(res.data) //打印商品数据+
        this.list = res.data
      })
    },
    //查询购物车数量,并传给父组件
    sendToparent(){
      var url = "searcart";
      this.axios.get(url).then(res=>{
        var arr = res.data;
        var sum = 0;
        for( var c of arr){
          sum += c.count
        }
        this.$emit("listenTochildEvent",sum)
        console.log(sum);
      })
    },
    addcart(lid,title,price,pic){
      console.log(10)
      var url = "addcart";
      var obj = {lid,title,price,pic}
      this.axios.get(url,{params:obj}).then(res=>{
        console.log(res)
        if(res.data.code==1){
          this.$toast('添加成功')
        }else{
          this.$toast('请登录')
          this.$router.push("/Login")
        }
      })
    },
    more(){
      this.pno++;
      if(this.pno<=2){
        var url = "product";
        var obj = {pno:this.pno}
        this.axios.get(url,{params:obj}).then(res=>{
          console.log(res.data)
          this.list = this.list.concat(res.data);
        })
      }else{
        this.$toast('没有更多啦')
      }
    }
  }
}
</script>
<style scoped>
*{margin:0;padding:0;}
.Ptitle img{
  width:100%;
  height:60px;
  margin-top:10px;
}
.content{
  display:flex;
  justify-content: center;
}
.head{
  background:#fff;
  box-sizing:border-box;
  padding:8px;
  width:368px;
  border-bottom:1px solid #efefef;
}
h3{
  font-size: 18px;
  color: #333;
  font-weight:400;
}
.products{
  display:flex;
  justify-content:center;
  flex-wrap: wrap;
}
.products div{
  width:183.5px;
  height:280px;
  background:#fff;
  box-sizing: border-box;
  display:flex;
  flex-direction:column;
  padding:4px;
  border-radius:4px;
  border:1px solid #efefef;
  margin-bottom:2px;
}
.products img{
  width:165px;
  height:165px;
  margin-left:5px;
}
h4{
  color: #F4C41C;
  font-size: 12px;
  font-weight: 700;
  font-family: verdana,arial;
}
h5{
  color: #36c;
  font-size: 12px;
  font-weight: 700;
}
.more{
  display:flex;
  justify-content: center;
}
.more .van-button{
  width:368px;
  color: #333;
  font-size: 0.42667rem;
}
</style>