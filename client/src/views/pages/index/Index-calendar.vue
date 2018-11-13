<template>
<div class="main-msg">
    <div class="container">
        <h2 class="package ask-msg">Muito conteúdo para organizar?</h2>
        <div class="mid-packages">
            <div class="package package-size package-background-lousa" :class="{active: animate}">
                
                <div class="flex-align lousa-title">
                    <span class="lousa-title-content">Matéria:</span>
                    <div class="package-label __half"></div>
                </div>
                <div class="package-separator"></div>
                <div>
                    <span>Conteúdo:</span>
                    <ul>
                        <li><div class="package-label __half"></div></li>
                        <li><div class="package-label __half"></div></li>
                        <li><div class="package-label __half"></div></li>
                    </ul>
                </div>
                <div class="package-separator"></div>
                <div class="text-right">
                    <span>Data: 12/05/2018</span>
                    
                </div>
                <div class="package-shadow">
                    <div class="shadow"></div>
                </div>
            </div>
            <div class="package package-size package-logo" :class="{active: animate}">
                <div class="relative">
                    <img src="@/assets/images/logo.png" alt="">
                </div>
                <div class="package-shadow">
                    <div class="shadow"></div>
                </div>
            </div>
            <div class="package package-size package-calendar" :class="{active: animate}">
                <div class="calendar">
                    <div class="calendar-header">
                        Jun
                    </div>
                    <div class="calendar-body">
                        <div class="calendar-cell">
                            
                        </div>
                        <div class="calendar-cell">
                            <div class="package-label __max"></div>
                            <div class="package-label __max"></div>
                        </div>
                        <div class="calendar-cell">
                            <div class="package-label __max"></div>
                        </div>
                        <div class="calendar-cell">
                            
                        </div>
                        <div class="calendar-cell"></div>
                        <div class="calendar-cell">
                            <div class="package-label __max"></div>
                        </div>
                        <div class="calendar-cell">
                            <div class="package-label __max"></div>
                            <div class="package-label __max"></div>
                        </div>
                        <div class="calendar-cell">
                            
                        </div>
                        <div class="calendar-cell">
                            <div class="package-label __max"></div>
                            <div class="package-label __max"></div>
                            <div class="package-label __max"></div>
                        </div>
                    </div>
                </div>
                <div class="package-shadow">
                    <div class="shadow"></div>
                </div>
            </div>
        </div>
        <h2 class="package help-msg">Que tal uma ajuda?</h2>
    </div>
</div>
</template>

<script>
    export default {
        name: 'index-calendar',
        data(){
        return{
                animate: false,
                divHeight: {
    				'height': '100%'
                }
            }
        },
        mounted (){
    		this.putMainDiv();
    		let animateComponents = Array.prototype.slice.call( document.getElementsByClassName('package')  );
    		animateComponents.forEach((component,index) =>{
    	    	setTimeout(function(){
     		        component.classList.add('active')
                },300 + 200 * index)
    		})
    	},
    	methods : {
    		putMainDiv(){
    			this.divHeight['height'] = window.innerHeight - 45 + 'px';		
    		}	
    	}
    }
    
</script>

<style lang="scss">
.main-msg{
    background-color: $primary;
    position: relative;
    padding: 45px 0;
    @include media($sm,'max'){
        padding-top: 25px;
    }
     .mid-packages{
        @include flex-align(0 0 auto);
        justify-content: space-between;
        margin: 80px 0 100px;
    }
    & > .container > h2{
        color: $white;
        text-shadow: 1px 1px 1px rgba(0,0,0,.6);
        font-size: 40px;
        font-weight: bolder;
        &.ask-msg{
            text-align: right;
            @include animation-spd(.8s);
            padding: 0 15px;
            transform: translate3d(150%,0,0);
            &.active{
                opacity : 1;
                transform: translate3d(0,0,0);
            }
        }
        &.help-msg{
            margin-top: 45px;
            @include animation-spd(.8s);
            padding: 0 15px;
            transform: translate3d(-150%,0,0);
            &.active{
                transform: translate3d(0,0,0);
                opacity: 1;
            }
        }
       
        @include media($md,'min'){
        }
    }
} 
.package{
    opacity: 0;
    .flex-align{
        align-items: center;
    }
    &-size{

        width: 320px;
        height: 195px;

        @include media($sm,'max'){
            width: 90%;
            margin: 0 auto;
            min-height: 180px;
        }
    }
    &-background-lousa{
        @extend .shadowbox;
        @include animation-spd(.8s);

        padding: 6px;
        background-color: #55846e;
        color: $white;
        border-radius: 4px;
        transform: translate3d(0,20%,0);
        &:after{
            @include pseudo(absolute,block);
            width: 100%;
            height: 2px;
            bottom: 0;
            left: 0;
            background-color: $white;
        }
        ul{
            padding-left: 25px;
            li{
                margin: -4px 0;
                &:before{
                    @include pseudo(relative, inline-block);
                    margin-right: 6px;
                    width: 6px;
                    height: 6px;
                    background-color: $white;
                    vertical-align: middle;
                }
                .package-label{
                    display: inline-block;
                }
            }
        }
        &.active{
          opacity: 1;
          transform: translate3d(0,-50%,0);
          @include media($sm,'max'){
              transform: translate3d(0,-30%,0);
          }
          .shadow{
                @include animation-spd(1.2s);
                width: 110%;
            }
        }
    }
     &-logo{
        @extend .shadowbox;
        @include animation-spd(.8s);

        img{
            position: absolute;
            left: 50%;
            top: 60%;
            transform: translate3d(-50%,-50%,0);
            height: 100%;
            width: 75%;
        }
        background-color: $white;
        display: block;
        transform: translate3d(0,70%,0);
        .relative{
            height: 100%;
            width: 100%;
        }
        
        h2{
            font-size: 70px;
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translate3d(-50%, -50%, 0);
            color: #4488d7;
            font-weight: bolder;
            border-radius: 4px;
        }
        &.active{
            opacity: 1 ;
            transform:  translate3d(0,0,0);
            .shadow{
                @include animation-spd(1.2s);
                width: 110%;
            }
        }
    }
    &-calendar{
        background-color: $white;
        transform: translate3d(0,90%,0);
        @extend .shadowbox;
        @include animation-spd(.8s); 
        .calendar{
            &-header{
                text-align: center;
                padding: 5px 0;
                display: block;
                width: 100%;
                font-size: 22px;
                color: $white;
                background-color: $dark-secundary;
                font-weight: bolder;
                text-shadow: 0 0 6px rgba(0,0,0,.5);
            }
            &-body{
                display: flex;
                flex-wrap: wrap;
                & > *{
                    flex: 1 1 33%;
                }
            }
            &-cell{
                border: 1px solid $medium-gray;
                height: 50px;
                .package-label{
                    margin: 5px;
                    box-shadow:0 1px 1px 1px rgba(0, 0, 0, 0.3);
                    &:nth-child(1){
                        background-color: $primary;
                    }
                    &:nth-child(2){
                        background-color: $error;
                    }
                    &:nth-child(3){
                        background-color: $dark-secundary;
                    }
                }
            }
        }
        &.active{
            opacity: 1;
            transform: translate3d(0,50%,0);
            @include media($sm,'max'){
                transform: translate3d(0,30%,0);
            }
            .shadow{
                @include animation-spd(1.2s);
                width: 110%;
            }
        }
    }
    &-label{
        height: 8px;
        display: block;
        border-radius: 6px;
        background-color: $white;
        @extend .shadowbox;
        
        &.__max{
            width: 90%;
        }
        &.__half{
            width: 50%;
        }
    }
    span:not(.default){
        text-shadow: 0 0 6px rgba(0,0,0,.5);
        font-weight: bolder;
    }
    &-shadow{
        position: relative;
        .shadow{
            position: absolute;
            width: 0;
            margin: 0 auto;
            height: 15px;
            background-color: rgba(0,0,0,.2);
            bottom: -40px;
            left: -5%;
            border-radius: 50%;
        }
    }
    &-separator{
        @extend .shadowbox;
        display: block;
        width: 100%;
        height:2px;
        background-color: $white;
        margin: 10px 0;
    }
}
</style>