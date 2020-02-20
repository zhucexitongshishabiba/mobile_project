<template>
  <div>
    <div class='title_pic'>
      <img src='https://s2.ax1x.com/2020/01/31/13DXoF.md.png'>
    </div>
    <!-- 购物车列表 -->
    <van-checkbox-group v-model="result" ref="checkboxGroup">
      <div class="list_cart" v-for="(p,i) of list" :key='i'>
        <van-swipe-cell>
          <van-cell>
            <div class="v-cell">
              <div class="Cart_left">
                <van-checkbox :name="p.count*p.price"/>
                <div class="Cart_pic">
                  <img :src="p.pic">
                </div>
              </div>

              <div class="Cart_right">
                <div class="details">
                  <p>{{p.title}}</p>
                </div>
                <p class="price">¥{{p.price.toFixed(2)}}</p>
                <!-- 步进器 -->
                <van-stepper
                v-model="p.count"
                :name="p.lid"
                @change="clear(p.count,p.lid)"
                />
              </div>
            </div>
          </van-cell>
          
          <template slot="right">
            <van-button @click="del(p.lid)" class="swip_btn" square type="danger" text="删除" />
          </template>
        </van-swipe-cell>
      </div>
    

      <!-- 结算 -->
      <div class='total'>
        <van-checkbox name="0" @click="checkAll">全选</van-checkbox>
        <span class="removeAll" @click="toggleAll" >取消全选</span>
        <div class="vbtn">
          <h3>合计</h3>:  <span class="allprice">¥{{sum.toFixed(2)}}</span>
          <van-button
          class="pay"
          round
          color="linear-gradient(to right, #FFD700, #FF7D40)"
          @click="pay"
          >结算
          </van-button>
        </div>
      </div>
    </van-checkbox-group>
  </div>
</template>
<script>
export default{
  data(){
    return{
      list:[],
      result:[],
      sum:0,
      timer:''
    }
  },
  created(){
    this.Load()
    // console.log(this.list)
  },
  beforeUpdate(){
    this.total()
    this.sendToparent()
  },
  methods:{
    // 整个页面初始化
    Load(){
      var url = "searcart"
      this.axios.get(url).then(res=>{
        this.list = res.data
        // console.log(res.data)
        // console.log(this.list)
      })
    },
    // 复选框
    checkAll() {
      this.$refs.checkboxGroup.toggleAll(true);
    },
    toggleAll(){
      this.result = [];
    },
    //修改复选框
    
    // 点击结算按钮
    pay(){
      if(this.result.length <= 1){
        this.$toast("请选择需要购买的商品")
      }else{
        this.$toast("购买成功")
      }
      console.log(this.result.length)
      console.log(this.list.length)
    },
    // 总价
    total(){
      var sum = 0;
      for(var p of this.result){
        sum += parseInt(p);
      }
      this.sum = sum;
    },
    //监听stepper value值变化,并且把值拿到数据库进行修改
    clear(count,lid){
      this.result = [];
      if(this.timer!==undefined){
        clearTimeout(this.timer);
      }
      this.timer = setTimeout(()=>{
        var obj = { count,lid };
        var url = 'updateCount';
        this.axios.get(url,{params:obj}).then(res=>{
        })
      },500)
    },
    //通过change事件获取数据库的购物车数量传给父组件改变info
    sendToparent(){
      var url = "searcart";
      this.axios.get(url).then(res=>{
        var arr = res.data;
        var sum = 0;
        for( var c of arr){
          sum += c.count
        }
        this.$emit("listenTochildEvent",sum)
        // console.log(sum);
      })
    },
    // 删除数据
    del(lid){
      // console.log(lid)
      var url = "delcart"
      var obj = {lid}
      this.axios.get(url,{params:obj}).then(res=>{
        console.log(1)
      })
      this.Load()
    },
  },
}
</script>
<style scoped>
*{margin:0;padding:0;}
.title_pic img{
  width:100%;
  margin-top:10px;
}
.products{
  background: #fff;
  border-radius: 5px;
  display:flex;
  box-sizing: border-box;
  padding:5px;
  border-bottom:3px dashed #f6f6f6;
}
.left{
  display:flex;
  margin-right:5px;
}
.cart_pic{
  width:100px;
  height:100px;
}
/* 购物车列表 */
.Cart_pic img{
  width:70px;
  height:70px;
}
.v-cell,.Cart_left{
  display:flex;
}
.Cart_pic{
  margin-left:10px;
  margin-top:8px;
}
.price,.van-stepper{
  display:inline-block;
}
.Cart_right{
  margin-left:10px;
}
.van-stepper{
  margin-left:80px;
}
.price{
  margin-top:5px;
  font-size: 13px;
  font-weight: 700;
  font-family: Tahoma,Arial,Helvetica,sans-serif;
  color: #f40;
}
.swip_btn{
  height:100%;
  font-size:18px;
}
/* 总计 */
.total{
  position:fixed;
  z-index:10;
  display:flex;
  top:563px;
  background:#fff;
  width:100%;
  box-sizing: border-box;
  padding:5px;
}
.vbtn{
  margin-left:40px;
}
.vbtn h3{
  display:inline-block;
}
.allprice{
  display:inline-block;
  width:50px;
  font-weight: 700;
  font-family: Tahoma,Arial,Helvetica,sans-serif;
  color: #f40;
}
.van-button{
  width:100px;
}
.pay{
  margin-left:10px;
}
.removeAll{
  width:60px;
  text-align: center;
  margin-left:10px;
  line-height: 44px;
}
</style>