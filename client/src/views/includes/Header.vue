<template>
    <header id="site">
      
      <b-navbar toggleable="md" type="dark" fixed="top">

        <b-navbar-toggle target="nav_collapse"></b-navbar-toggle>
        
        <b-navbar-brand :to="{name: 'Index'}">The Foca</b-navbar-brand>
        
        <b-collapse is-nav id="nav_collapse">
        
          <b-navbar-nav>
            <b-nav-item :to="{name: 'Contato'}">Fale Conosco</b-nav-item>
            <b-nav-item :to="{name: 'Events'}">Dashboard</b-nav-item>
            <b-nav-item v-if="isUserLoggedIn" :to="{name: 'Balance'}">Balance</b-nav-item>
            <!--<b-nav-item :to="{name: 'Learning'}">Learning</b-nav-item>-->
            <!-- <B-NAV-ITEM HREF="#" DISABLED>DISABLED</B-NAV-ITEM> -->
          </b-navbar-nav>
        
          <!-- Right aligned nav items -->
          <b-navbar-nav class="ml-auto">
            
            <b-nav-item v-if="!isUserLoggedIn" :to="{name: 'Login'}">Login</b-nav-item>
        
            <b-nav-item-dropdown right v-else>
              <template slot="button-content">
                <b>User</b>
              </template>
                <!--<b-dropdown-item href="#">Perfil</b-dropdown-item>-->
                <b-dropdown-item :to="{name: 'Style Guide'}">Style Guide</b-dropdown-item>
                <b-dropdown-item :to="{name: 'Change Password'}">Mudar Senha</b-dropdown-item>
                <b-dropdown-item @click="logout">Sair</b-dropdown-item>
            </b-nav-item-dropdown>
          </b-navbar-nav>
        
        </b-collapse>
        </b-navbar>
    </header>
</template>
<script>
import {mapState} from 'vuex'
import AuthService from '@/services/Authentication'
  export default{
      name: 'cHeader',
      computed: {
        ...mapState([
          'isUserLoggedIn'
        ])
      },
      methods: {
        async logout(){
          let response = await AuthService.logout();
          if(!response.status){
            this.$swal({
              type: 'error',
              title: 'Ops ...',
              text: 'Ocorreu um erro ao deslogal. Tente novamente mais tarde'
            })
            return
          }
          this.$store.dispatch('setPasswordValidState', false)
          this.$store.dispatch('setToken', null)
          this.$router.push({
            name: 'Login'
          })
        }
      }
  }
  
</script>

<style lang="scss">
header#site{
  .navbar{
    background-color: $dark-secundary;
    color: $primary;
    box-shadow: 0 0 18px rgba(0,0,0,.6);
    padding: 0;
    .navbar-nav .nav-link,.navbar-brand{
      color: $white;
      font-weight: bolder;
      padding: 10px 15px;
      margin: -2px 0;
    }
    .navbar-nav .nav-link{
      @extend .fast-e;
      &:hover,&.active{
        background-color: lighten($dark-secundary,5%);
        text-shadow:1px 1px 1px rgba($black,.5);
        color: $white;
      }
    }
  }
}
    
</style>