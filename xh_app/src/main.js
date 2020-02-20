import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import Vant from 'vant'
import 'lib-flexible'
import './assets/iconfont/iconfont.css'
Vue.use(Vant)
import 'vant/lib/index.css'

//5:引入第三方ajax库axios
//6:引入axios
import axios from "axios"
//7:配置访问服务器基础地址
axios.defaults.baseURL="http://127.0.0.1:2020/"
//8:配置发送请求保存session信息
axios.defaults.withCredentials=true;
//9:将axios注册vue
Vue.prototype.axios = axios;

Vue.config.productionTip = false

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
