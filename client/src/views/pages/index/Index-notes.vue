<template>
    <div class="index-notes">
        <div class="container">
            <div class="leaf-container">
                <paper-leaf :lines="paperLeafLines" />
                <h2>Deixe o foca <br> <span>ajudar você</span></h2>
                <div class="paper-description">
                    <ul>
                        <li>
                            Que tal organizar seus estudos em um só lugar?
                        </li>
                        <li>
                            Acessar suas anotações quando e onde você quiser.
                        </li>
                        <li>
                            Salvar e reproduzir links de vídeos enquanto cria suas anotações.
                        </li>
                    </ul>
                </div>
                <div class="fake-video-container">
                    <div class="fake-video">
                        <div class="fake-video-screen"></div>
                        <div class="fake-video-icon">
                            <div class="icon-play"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import PaperLeaf from '@/components/paper-leaf';
    export default {
        name: 'index-notes',
        data(){
           return {
                paperLeafLines: 14
            }  
        },
        components: {
            PaperLeaf
        }
    }
</script>

<style lang="scss">
    .index-notes {
        .container {
            padding: 55px 0;
        }
    }
    .fake-video-container{
        position: absolute;
        top: 314px;
        left: 50%;
        transform: translate3d(-50%,0,0);
    }
    .fake-video {
        margin-bottom: 25px;
        position: relative;
        &-screen {
            border-radius: 2px;
            margin: 0 auto;
            width: 400px;
            height: 200px;
            background-color: $black;
            border: 1px solid $medium-gray;
        }
        &-icon {
            position: absolute;
            top: 50%;
            left: 50%;
            height: 50px;
            width: 75px;
            border-radius: 10px;
            background-color: $medium-gray;
            display: block;
            transform: translate3d(-50%,-50%,0);
            z-index: 10;
            .icon-play{
                position: absolute;
                top: 50%;
                left: 53%;
                transform: translate3d(-50%,-50%,0);
                height: 0;
                width: 0;
                display: block;
                border-top: 15px solid transparent;
                border-bottom: 15px solid transparent;
                border-left: 15px solid $black;
                z-index: 10;
            }
        }
    }
    
    .leaf-container{
        position: relative;
        h2 {
            position: absolute;
            top: 4px;
            left: 6%;
            line-height: 45px;
            font-size: 45px;
            text-align: left;
            color: darken($primary,5%);
            font-weight: bolder;
            @include media($md,'min'){
                span { 
                    margin-left: 330px;
                }    
            }
        }
        .paper-description {
            margin: 0 8%;
            
            ul {
                position: absolute;
                top: 153px;
                left: 11%;
                list-style: disc;
                font-size: 22px;
                
                li {
                    
                    line-height: 34px;
                    text-align: left;
                    margin-bottom: 11px;
                }
            }
        }
    }
</style>