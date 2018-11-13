<template>
    <div id="learning">
        <div class="container">
            <div class="input-container">
                <input type="text" v-model="event.linkVideo" class="form-control">
            </div>
            <!--<div class="desktop-only">-->
            <!--    <ul>-->
            <!--        <li @click="learningContainerClass = 'layout-1'">1</li>-->
            <!--        <li @click="learningContainerClass = 'layout-2'">2</li>-->
            <!--        <li @click="learningContainerClass = 'layout-3'">3</li>-->
            <!--    </ul>-->
            <!--</div>-->
            <div class="learning-container" :class="learningContainerClass">
                
                <div class="frame" :style="{height: iframeHeight}">
                    <iframe :src="formattedUrl"></iframe>    
                </div>
                
                <div class="anotacao">
                    <vue-editor v-model="event.anotacao"></vue-editor>
                </div>
                
            </div>
            <div class="action text-center">
                <button class="btn bg-orange" @click="salvar()">Salvar</button>
            </div>
            <div class="aside-tags-container" :class="{'expand' : expandedAside}">
                <div class="aside-tags">
                    <div class="aside-tags-title">
                        Lista de afazeres:
                    </div>
                    <ul class="tags-list">
                        <li v-for="tag in event.dsAssunto" :key="tag.id">
                            <input type="checkbox"> {{tag.nome | firstUpper}}
                        </li>
                    </ul>
                </div>
                <button class="btn btn-aside-toggle bg-main" @click="expandedAside = !expandedAside">
                    <span class="icon-bar top-bar"></span>
                    <span class="icon-bar middle-bar"></span>
                    <span class="icon-bar bottom-bar"></span>
                </button>
            </div>
        </div>
    </div>
</template>

<script>
    import { debounce } from 'lodash-es';
    import { VueEditor } from "vue2-editor";
    import EventServ from '@/services/Event'
    export default{
        name: 'Learning',
        components:{ 
            VueEditor
        },
        data() {
            return {
                iframeHeight: 'auto',
                formattedUrl: '',
                learningContainerClass: 'layout-1' ,
                event: {
                    linkVideo: '',
                    anotacao: ''
                },
                expandedAside: true,
            };
        },
        mounted() {
            
            window.addEventListener('resize', this.handleResize)
            this.handleResize();
            
            let event = this.$parent.event;
            
            if(!event){
                this.getEvent();
            } else{
                this.event = this.$parent.event;    
            }
            
            setTimeout(function() {
                this.expandedAside =  false;
            }.bind(this), 500)
            
        },
        beforeDestroy() {
            window.removeEventListener('resize', this.handleResize)
        },
        methods: {
            handleResize(){
                let _iframeHeight = (window.innerWidth * 0.35) + 'px';
                this.iframeHeight = _iframeHeight;
            },
            async salvar(){
                // console.log(this.event)
                let response = (await EventServ.put(this.event))
                
                if(response.status)
                    console.log('Atualizado')
            },
            async getEvent(){
                let response = (await EventServ.getOne(this.idEvent))
                
                if(response.status)
                    this.event = response.data;
            }
        },
        watch: {
            'event.linkVideo' : debounce(function(){
                let url  = this.event.linkVideo, code;
                
                if(!url)
                    return;
                    
                const regExp = /\?v=.+/g
                let match = regExp.exec(url)
                
                if(!match){
                    console.log('No Match');
                    return;
                }
                else
                    code = match[0].replace('?v=', '')
                    
                this.formattedUrl = 'https://www.youtube.com/embed/' + code.trim();
            },500)
        },
        props: [
            'idEvent'    
        ]
    };
</script>

<style lang="scss">
    #learning{
        padding-top: 35px;
        position: relative;
        .input-container{
            width: 45%;
            margin: 0 auto 15px;
        }
        
        .learning-container{
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            /*&.layout{*/
            /*    &-1{*/
            /*        background-color: rgba($primary,.3);*/
            /*    }*/
                
            /*    &-2{*/
            /*        background-color: rgba($secundary,.3);*/
            /*    }*/
                
            /*    &-3{*/
            /*        background-color: rgba($warning,.3);*/
            /*    }*/
            /*}*/
        }
        .frame{
            border: 3px solid $light-gray;
            border-radius: 6px;
            width: 80%;
            height: auto;
            margin-bottom: 10px;
            iframe{
                width: 100%;
                height: 100%;
            }
        }
        .anotacao{
            border: 3px solid $light-gray;
            border-radius: 6px;
            width: 80%;
        }
        
        .resizable{
            padding: 8px;
            resize: both;
            overflow: auto;
            &-x{
                padding: 8px;
                resize: horizontal;
                overflow: auto;
            }
            &-y{
                padding: 8px;
                resize: vertical;
                overflow: auto;
            }
        }
        .aside-tags-container {
            .aside-tags { 
                position: fixed;
                right: 0;
                top: 45px;
                background-color: $secundary;
                padding: 5px 25px;
                height: 100%;
                color: $white;
                font-weight: bolder;
                transform: translate3d(100%,0,0);
                
                @include animation-spd(.38s);
                
                input[type="checkbox"] { 
                    margin-right: 6px;
                }
                &-title {
                    font-size: 20px;
                    margin-bottom: 10px;
                }
            }
            &.expand{
                .aside-tags{
                    transform: translate3d(0,0,0);     
                }
                .btn-aside-toggle {
                    padding: 2px 1px 3px 3px;
                    .icon-bar{
                        width: 32px;
                        background-color: $primary;
                        &.top-bar {
                            transform: rotate(45deg);
                            transform-origin: 6px 6px;
                          }
                          
                        &.middle-bar {
                            opacity: 0;
                        }
                        
                        &.bottom-bar {
                            transform: rotate(-45deg);
                            transform-origin: 8px 0px;
                        }
                    }
                }
            }
            .btn-aside-toggle{
                position: fixed;
                padding: 0;
                right: 10px;
                left: initial;
                top: 43px;
                padding: 2px 8px;
                background-color: $white;
                .icon-bar{
                    background-color: $primary;
                    margin: 4px 0;
                    display: block;
        		    border-radius: 4px;
        		    width: 25px;
        		    height: 3px;
        		    @extend .slow-e;
                }
            }
        }
    }
</style>