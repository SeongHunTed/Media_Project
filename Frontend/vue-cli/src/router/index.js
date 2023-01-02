import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '../views/HomeView.vue'
import LogInView from '@/views/LogInView'
import TestView from '@/views/TestView'
import SignUpView from '@/views/SignUpView'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: HomeView
  },
  {
    path: '/about',
    name: 'about',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/AboutView.vue')
  },
  {
    path: '/login',
    name: 'LogInView',
    component: LogInView
  },
  {
    path: '/login/next',
    name: 'TestView',
    component: TestView
  },
  {
    path: '/signup',
    name: 'SignUpView',
    component: SignUpView
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
