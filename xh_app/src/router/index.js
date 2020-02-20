import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from "../views/users/Login.vue"
import Regist from "../views/users/Regist.vue"
import Home_page from "../views/home/Home_page.vue"

Vue.use(VueRouter)

const routes = [
  {path:'/Login',component:Login},
  {path:'/Regist',component:Regist},
  {path:'/Home_page',component:Home_page},
  {
    path: '/about',
    name: 'about',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
  }
]

const router = new VueRouter({
  routes
})

export default router
