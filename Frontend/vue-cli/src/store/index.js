import Vue from 'vue'
import Vuex from 'vuex'
// import createPersistedState from 'vuex-persistedstate'
import router from '@/router'
import axios from 'axios'

Vue.use(Vuex)

const API_URL = 'http://127.0.0.1:8000'

export default new Vuex.Store({
    state: {
        username : '',
        password : '',
        token : ''
    },
    mutations: {
        // login: function (state, payload) {
        //     state.username = payload.username
        //     state.password = payload.password
        //     state.token = payload.token
        // },
        // loginCheck: function (state) {
        //     if (!state.token) {
        //         router.push({
        //             name: 'login'
        //         }).catch(error => {
        //             console.log(error)
        //         })
        //     }
        // }
        SAVE_TOKEN(state, token) {
          state.token = token
        },
        SAVE_USER_INFO(state, userInfo) {
          state.token = userInfo.token
          state.username = userInfo.username
        },
    },
    actions: {
      logIn(context, payload) {
        const username = payload.username
        const password = payload.password
        axios({
          method: 'post',
          url: `${API_URL}/dj-accounts/login/`,
          data: {
            username, password
          }
        })
          .then(res => {
            context.commit('SAVE_TOKEN', res.data.key)
            context.commit('SAVE_USER_INFO', {
              userToken: res.data.key,
              username: username,
            })
            router.push({ name: 'Home' })
            return 
          })
          .catch(err => 
            console.log(err))
      },
      signUp(context, payload) {
        const username = payload.username
        const password1 = payload.password1
        const password2 = payload.password2
        axios({
          method: 'post',
          url: `${API_URL}/dj-accounts/signup/`,
          data: {
            username, password1, password2
          }
      })
      .then(res => {
        context.commit('SAVE_TOKEN', res.data.key)
        router.push({ name: 'LogInView' })
      })
      .catch(err => {
        console.log(err)
        alert('양식을 준수해주세요')
        return
        })
      }
    },
    getters: {
      getUsername(state) {
        console.log(state.username)
        return state.username;
      },
    }
})