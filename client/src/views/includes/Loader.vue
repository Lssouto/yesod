<template>
    <div class="loader-container" 
         :class="[ {enter: enter}, {leave: leave}, {hide: hide}, {hidden: hidden}, {'partial-loader' : isPartial}]" >
        <div class="loader-center">
            <div class="fingerprint-spinner">
                <div class="spinner-ring"></div>
                <div class="spinner-ring"></div>
                <div class="spinner-ring"></div>
                <div class="spinner-ring"></div>
                <div class="spinner-ring"></div>
                <div class="spinner-ring"></div>
                <div class="spinner-ring"></div>
                <div class="spinner-ring"></div>
                <div class="spinner-ring"></div>
            </div>
        </div>    
    </div>
</template>
<script>
    export default {
        name: 'Loader',
        data(){
            return{
                enter: false,
                leave: true,
                hide: true,
                hidden: true,
                isPartial: true,
                divHeight: {
                    height: 'auto',
                    width: 'auto'
                }
            }  
        },
        mounted(){
            // const self = this;
            // this.show(false);
            // setTimeout(()=>{
            //     self.remove();
            // },1000)  
            // setTimeout(()=>{
            //     self.show(true);
            // },3000)  
            // setTimeout(()=>{
            //     self.remove();
            // },5000)  
            // setTimeout(()=>{
            //     self.show(false);
            // },7000)  
            // setTimeout(()=>{
            //     self.remove();
            // },9000)  
            // setTimeout(()=>{
            //     self.show(true);
            // },7000)  
        },
        methods: {
            show(isPartial){
                
                if(!this.hidden)
                    return;
                    
                this.isPartial = isPartial;
                const vm = this;
                this.hidden = false;
                setTimeout(()=>{
                    vm.hide = false;    
                },200)
                
                setTimeout(()=>{
                    vm.enter = true;
                    vm.leave = false;
                },500)
                
            },
            remove(){
                const vm = this;
                this.enter = false;
                setTimeout(() => {
                    vm.leave = true;
                }, 250);
                setTimeout(() => {
                    vm.hide = true;
                }, 850);
                setTimeout(() => {
                    vm.hidden = true;
                }, 1150);
            }
        }
    }
</script>
<style lang="scss">
    .loader-container{
        position: fixed;
        left: 0;
        top: 0;
        width: 100%;
        z-index: 1000;
        height: 100%;
        background-color: rgba($black,.3);
        @include animation-spd(.75s);
        
        &.leave{
            /*animation: loader-container 1.2s forwards;*/
            .loader-center{
                animation: loader-press 1s forwards;
            }
        }
        
        &.hide .loader-center{
            padding: 130px;
            opacity: 0;
        }
        
        &.partial-loader{
            width: 0;
            height: 0;
            top: initial;
            left: initial;
            bottom: 80px;
            right: 80px;
        }
    }
    
    .loader-center{
        position: absolute;
        left: 50%;
        top: 50%;
        transform: translate(-50%,-50%);
        padding: 20px;
        border-radius: 50%;
        background-color: $white;
        box-shadow: 0 0 6px 1px rgba(0,0,0,.215);
        @include animation-spd(.40s);
    }
    
    .fingerprint-spinner {
        height: 64px;
        width: 64px;
        padding: 2px;
        position: relative;
      
        .spinner-ring {
            position: absolute;
            border-radius: 50%;
            border: 2px solid transparent;
            border-top-color: $primary;
            animation: fingerprint-spinner-animation 1500ms cubic-bezier(0.680, -0.750, 0.265, 1.750) infinite forwards;
            margin: auto;
            bottom: 0;
            left: 0;
            right: 0;
            top: 0;
            
            @for $i from 1 through 9{
              &:nth-child(#{$i}){
                height: calc(60px / 9 + (#{$i}-1) * 60px / 9);
                width: calc(60px / 9 + (#{$i}-1) * 60px / 9);
                animation-delay: calc(50ms * #{$i});
              }
            }
        }
        
    }
    @keyframes fingerprint-spinner-animation {
        100% { transform: rotate( 360deg ); }
    }
    @keyframes loader-container{
        0% { background-color: rgba($black,.5) }
        40% { background-color: rgba($black,1) }
        50% { background-color: rgba($black,.3) }
        100% { background-color: rgba($black, 0) }
    }
    @keyframes loader-press{
        0% { transform: translate3d(-50%,-50%,0px) scale(1); }
        40% { transform: translate3d(-50%,-50%,0px) scale(1.18,1.18); }
        50% { transform: translate3d(-50%,-50%,0px) scale(0.85,0.85); }
        100% { transform: translate3d(-50%,-50%,0px) scale(1,1); }
    }
</style>