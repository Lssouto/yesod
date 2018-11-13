<template>
    <div id="dashboard" ref="dashboard">
        <router-view @updateEventValue="updateEventValue"></router-view>
        <pomodoro />
    </div>
</template>
<script>
    import Pomodoro from './Pomodoro';
    export default {
        name: "Dashboard",
        data(){
            return { 
                event: null
            }
        },
        methods: {
            updateEventValue(val){
                this.event = val;
            }
        },
        components: {
            Pomodoro
        }
    }
</script>
<style lang="scss">
    .dashboard{
        position: fixed;
        right: 0;
        top: 45px;
        /*box-shadow: 0 18px 18px rgba(0,0,0,.6);*/
        background-color: $primary;
        z-index: 75;
        @extend .fast-e;
        &-link{
            padding: 10px;
            color: $white;
            @extend .fast-e;
            display: block;
            &:hover{
                color: $white;
                background-color: darken($primary,10%);
                text-shadow:1px 1px 1px rgba($black,.5);
            }
        }
        &-hide{
          transform: translate3d(200px,0,0);  
        }
        &-list{
            li{
                display: block;
            }
        }
    }
</style>