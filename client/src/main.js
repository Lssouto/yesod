import Vue from 'vue'
import App from './App'
import router from './router'

import BootstrapVue from 'bootstrap-vue'
Vue.use(BootstrapVue)

  import 'bootstrap/scss/bootstrap.scss'
  import 'bootstrap-vue/dist/bootstrap-vue.css'

import VueSweetalert2 from 'vue-sweetalert2';
Vue.use(VueSweetalert2);

import { sync } from 'vuex-router-sync'
import store from '@/store/store'

Vue.config.productionTip = false

sync( store, router )

Vue.filter('firstUpper', (value)=>{
  if(!value)
    return
  else
    return value.substring(0,1).toUpperCase() + value.substring(1);
})

Vue.filter('dateformat', (value)=>{
  return new Date(value).toLocaleString('pt-br');
})

Vue.filter('round', (value)=>{
  return Math.round(value * 100) / 100;
})

export default new Vue({
  el: '#app',
  router,
  store,
  components: { App },
  template: '<App/>'
})


router.beforeEach((to, from, next) => {
  //É uma rota que precisa de autenticacao??
  if (to.matched.some(record=> record.meta.login)) {
    
    //Esta Logado e com senha nao expirada? -> next
    if(store.state.isUserLoggedIn && store.state.isPasswordValid){
      next()
    }
    else{
      //Ele nao está logado ? -> Manda logar
      if(!store.state.isUserLoggedIn){
        next({
          name: 'Login'
        })
      }
      else{
        //Senha expirou ? -> Manda trocar
        if(!store.state.isPasswordValid){
          
          //Senha expirou e esta indo trocar? next : manda trocar
          if(to.name == 'Change Password'){
            next()
          }
          else{
            next({
              name: 'Change Password'
            })
          }
        }
      }
    }
  }
  else{
    next()
  }
})
