<template>
    <div class="paper-leaf">
        
        <div class="margin-left" :style="{height: marginLineHeight }"></div>
        <div class="margin-right" :style="{height: marginLineHeight }"></div>
        <div class="paper-leaf-line" v-for="line in lines"></div>
    </div>
</template>
<script>
    export default {
        name: 'paper-leaf',
        props: [
            'lines'
        ],
        computed: {
            marginLineHeight: function(){
                const lineHeigth = 45;
                const val = (this.lines * lineHeigth) + 'px';
                return val; 
            }
        }
    }
</script>
<style lang="scss">
.paper-leaf{
    background-color: $white;
    width: 100%;
    position: relative;
    @extend .shadowbox;
    
    &-line{
        height: 45px;
        display: block;
        
        &:not(:last-child){
            border-bottom: 1px solid $primary;    
        }
    }
    div[class^="margin"]{
        position: absolute;
        top: 0;
        width: 1px;
        background-color: $primary;
    }
    .margin {
        &-left{
            left: 5%;
        }
        &-right{
            left: initial;
            right: 5%;
            opacity: 0.3;
        }
    }
}
</style>