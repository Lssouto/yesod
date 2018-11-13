import Vue from 'vue'
import Router from 'vue-router'

//Pages
import Index from '@/views/pages/index/Index'

//User
  import Login from '@/views/pages/user/Login'
  import ChangePassword from '@/views/pages/user/ChangePwd'
  import FgtPwd from '@/views/pages/user/FgtPwd'
  import NewUser from '@/views/pages/user/New'

import Contato from '@/views/pages/Contato'
import Dashboard from '@/views/pages/dashboard/Dashboard'
  import Balance from '@/views/pages/dashboard/Balance'
  import Events from '@/views/pages/dashboard/Events'
  import AddEvent from '@/views/pages/dashboard/AddEvent'
  import PutEvent from '@/views/pages/dashboard/PutEvent' 
  import Learning from '@/views/pages/dashboard/Learning'  

//Others  
import StyleGuide from '@/views/pages/Style-guide'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Index',
      component: Index
    },
    {
      path: '/login',
      name: 'Login',
      component: Login
    },
    {
      path: '/cadastrar-se',
      name: 'NewUser',
      component: NewUser
    },
    {
      path: '/esqueci-a-senha',
      name: 'FgtPwd',
      component: FgtPwd
    },
    {
      path: '/nova-senha',
      name: 'Change Password',
      component: ChangePassword,
      meta: {
        login: true
      }
    },
    {
      path: '/dashboard',
      component: Dashboard,
      meta: {
        login: true
      },
      children: [{
        path: '',
        name: 'Events',
        component: Events        
      },
      {
        path: 'editar/:idEvent',
        name: 'PutEvent',
        component: PutEvent,
        props: true
      },
      // {
      //   path: 'balance',
      //   name: 'Balance',
      //   component: Balance
      // },
      {
        path: 'addevent',
        name: 'AddEvent',
        component: AddEvent
      },
      {
        path: 'learning/:idEvent',
        name: 'Learning',
        component: Learning,
        props: true
      }
      ]
    },
    {
      path: '/balance',
      name: 'Balance',
      component: Balance,
      meta: {
        login: true
      },
    },
    {
      path: '/fale-conosco',
      name: 'Contato',
      component: Contato
    },
    {
      path: '/style-guide',
      name: 'Style Guide',
      component: StyleGuide
    },{
      path: '**',
      name: 'Index',
      component: Index
    }
  ],
  mode: 'history'
})
