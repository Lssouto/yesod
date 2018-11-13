<template>
  <div id="app">
    <c-header />
    <loader ref="app-loader"/>
    <transition name="fade">
      <router-view @error="error"/>
    </transition>
    <c-footer />
  </div>
</template>

<script>
import cHeader from '@/views/includes/Header'
import cFooter from '@/views/includes/Footer'
import Loader from '@/views/includes/Loader'
export default {
  name: 'App',
  components:{
    cHeader,
    Loader,
    cFooter
  },
  methods: {
    error(message){
      this.$swal({
          type: 'error',
          title: 'Oops...',
          text: message
      })
    }
  }
}
</script>

<style lang="scss">
@import url('https://fonts.googleapis.com/css?family=Montserrat:100,300,400,500,700');
#app{
  padding-top: 45px;
  font-family: 'Montserrat', 'Arial', 'sans-serif';
}
</style>