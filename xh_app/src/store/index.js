import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {//集中管理数据函数
    cartcount:""
  },
  getters:{//集中获取数据函数
    getcount(state){
      return state.cartcount 
    }
  },
  mutations: {//集中修改数据函数
    addinfo(state,num){
      state.cartcount = num;
    }
  },
  actions: {
  },
  modules: {
  }
})
