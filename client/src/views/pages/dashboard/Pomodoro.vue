<template>
    <div id="pomodoro">
        <div class="alert-effect" :class="{'active': activeEffect}"></div>
        <div class="fixed-container" :class="show">
            <div class="pomodoro-toggle">
                <div class="toggle-help" @click="toggleShow('show-help')">?</div>
                <div class="toggle-config" @click="toggleShow('show-config')">C</div>
                <div class="toggle-hide" @click="toggleShow(null)">_</div>
            </div>
            <div class="tomato" @click="toggleShow('show-start')"></div>
            <pomodoro-timer :time="pomodoroComponentTime" @finished="verifyIfContinueWithPomodoro" />
            <div class="information-container">
                <div class="pomodoro-help">
                    <div class="btn-hidde-container" @click="showMessage = false;toggleShow(null)">x</div>
                    <div class="title">
                        Como funciona?
                    </div>
                    <ol type="1">
                        <li>Faça uma lista com objetivos de estudo;</li>
                        <li>Desligue celular, TV ou qualquer distração;</li>
                        <li>Agora é o SEU momento de estudo;</li>
                        <li>O pomodoro funciona em intervalos;</li>
                        <li>25 minutos focado;</li>
                        <li>5 minutos de descanso;</li>
                        <li>e um descanso maior após 3 sessões;</li>
                    </ol>
                </div>
                <div class="pomodoro-config">
                    <div class="btn-hidde-container" @click="showMessage = false;toggleShow(null)">x</div>
                    <div class="title">
                        Duração do intervalo
                    </div>
                    <input type="number" v-model="pomodoroTime" class="form-control" min="15" max="30" @blur="validatePomodoroTime()" />
                    <br>
                    <div class="pomodoro-config-information">
                        Tempo de Pausa:
                        {{ restPomodoroTime }} min
                    </div>
                </div>
                <div class="pomodoro-start">
                    <div class="title">
                        Iniciar Pomodoro ?
                    </div>
                    <div class="actions">
                        <button class="btn btn--min __no-shadow bg-secundary" @click="start()">Sim</button>
                        <button class="btn btn--min __no-shadow bg-error" @click="toggleShow(null)">Não</button>
                    </div>
                </div>
            </div>
            <div class="alert-container" :class="{'active': showMessage}">
                <div class="btn-hidde-container" @click="showMessage = false;toggleShow(null)">x</div>
                <div class="pomodoro-alert-title"> {{ pomodoroAlert.title }} </div>
                <div class="pomodoro-alert-text"> {{ pomodoroAlert.text }} </div>
            </div>
        </div>
    </div>
</template>
<script>
    import PomodoroTimer from '@/components/dashboard/Pomodoro-timer'
    export default {
        name: "Pomodoro",
        data(){
            return { 
                show: '',
                pomodoroTime: 25, //min
                pomodoroComponentTime: 0,
                pomodoroCounter: 8,
                pomodoroAlert: {
                    title: 'Hey, ^.~',
                    text: 'Hora de dar uma pausa.'
                },
                activeEffect: false,
                showMessage: false
            };
        },
        methods: { 
            toggleShow(value) {
                if (this.show == value || !value) {
                    this.show = '';
                } else { 
                    this.show = value;
                }
            },
            validatePomodoroTime() {
                if (this.pomodoroTime < 15)
                    this.pomodoroTime = 15;
                else if (this.pomodoroTime > 30)
                        this.pomodoroTime = 30;
            },
            toggleEffect(){
                if(!this.activeEffect){
                    this.showMessage = false;
                    this.activeEffect = true;
                    this.toggleShow(null);
                    setTimeout(function(){
                        this.activeEffect = false;
                    }.bind(this), 420)
                    setTimeout(function(){
                        this.showMessage = true;
                    }.bind(this), 1480)
                } 
            },
            start(){
                if(!this.pomodoroCounter){
                    this.pomodoroCounter = 8;
                    return;
                }
                
                this.pomodoroComponentTime = 0;
                
                if (this.pomodoroCounter % 2 == 0 ){
                    this.toggleShow(null);
                    this.pomodoroComponentTime = this.pomodoroTime;        
                    this.pomodoroCounter--;
                } else {
                    this.pomodoroComponentTime = this.restPomodoroTime;
                    this.pomodoroCounter--;
                }
            },
            verifyIfContinueWithPomodoro(){
                this.toggleEffect();
                if (this.pomodoroCounter % 2 == 0 ) {
                    this.pomodoroAlert.title = "Hey";
                    this.pomodoroAlert.text = "Hora de produzir";
                } else {
                    if (this.pomodoroCounter != 1){
                        this.pomodoroAlert.title = "Hey";
                        this.pomodoroAlert.text = "Que tal descansar um pouco?";
                        
                    } else {
                        this.pomodoroAlert.title = "Hey";
                        this.pomodoroAlert.text = "Hora de dar uma pausa maior";
                        this.pomodoroCounter--;
                        return;
                    }
                }
                let vm = this;
                const TWENTYSECONDS = 10000;
                setTimeout(function(){
                    vm.start()    
                }, TWENTYSECONDS)
                
            }
        },
        computed: {
            // convertedPomodoroTime: function(){
            //     return this.pomodoroTime * 60 * 1000;
            // },
            restPomodoroTime: function(){
                return this.pomodoroTime / 5;
            }
        },
        components: {
            PomodoroTimer,
        },
    };
</script>
<style lang="scss">
$color-tomato: #ff6633;
    #pomodoro {
        .fixed-container{
            position: fixed;
            bottom: 10px;
            left: 15px;
            transform: translate3d(0,0,0);
            @include animation-spd(.3s);
            
            &.show-config,&.show-help,&:hover {
                .pomodoro-toggle {
                    opacity: 1;
                }
                .pomodoro-timer-value {
                    opacity: 1;
                }
            }
            
            &.show-config {
                transform: translate3d(0,-160px,0);
                @include animation-spd(.5s);
            }
            &.show-help {
                transform: translate3d(0,-265px,0);
                @include animation-spd(.5s);
            }
            &.show-start {
                transform: translate3d(0,-120px,0);
                @include animation-spd(.5s);
            }
            
            &.show-config .pomodoro-config,
            &.show-help .pomodoro-help,
            &.show-start .pomodoro-start {
                opacity: 1;
                z-index: 10;
            }
        }
        .pomodoro { 
            &-config,&-help,&-start {
                position: absolute;
                opacity: 0;
                top: 0;
                left: -15px;
                display: block;
                background-color: $color-tomato;
                color: $white;
                border-radius: 0 20px 20px 0;
                padding: 10px 15px 10px 25px;
                z-index: 5;
                @include animation-spd(.4s);
                .title{
                    color: $white;
                }
            }
            &-help {
                width: 425px;
            }
            &-config {
                width: 220px;
                &-information {
                    font-size: 14px;
                }
                .form-control {
                    width: 80px;
                    margin: 0 auto;
                }
            }
            &-start {
                width: 200px;
                .title { 
                    margin: 5px 0 8px 0;
                }
                .actions { 
                    display: flex;
                    justify-content: space-between;
                }
            }
            &-toggle { 
                opacity: 0;
                @extend .slow-e;
                @include flex-align(1 1 33%);
                [class^="toggle-"] {
                    cursor: pointer;
                }
            }
        }
        .information-container {
            position: relative;
        }
        .alert-container { 
            position: fixed;
            left: -15px;
            bottom: 0;
            background-color: $color-tomato;
            color: $white;
            z-index: 9999;  /*Before loader*/
            width: 220px;
            border-radius: 0 20px 20px 0;
            @include animation-spd(.55s);
            transform: translate3d(-100%,0,0);
            &.active {
                transform: translate3d(0,0,0);    
            }
            .pomodoro-alert {
                
                &-title,&-text{
                    text-align: center; 
                    text-shadow: 1px 1px rgba($black, .3);
                    font-weight: bolder;
                }
                &-title {
                    font-size: 20px;
                    margin-bottom: 8px;
                }
                
                &-text {
                    font-size: 16px;
                    margin-bottom: 6px;
                }
            }
        }
        .tomato { 
            height: 38px;
            width: 50px;
            background-color: $color-tomato;
            display: inline-block;
            border-radius: 25px;
            cursor: pointer;
            position: relative;
            @extend .slow-e;
            &:hover {
                transform: scale(1.1,1.1);
            }
            &:before { 
                @include pseudo(absolute, block);
                height: 14px;
                width: 14px;
                background-color: $secundary;
                border-radius: 50%;
                left: 50%;
                transform: translateX(-50%);
                top: -5px;
            }
        }
        .btn-hidde-container{
            position: absolute;
            background-color: $white;
            top: 0;
            right: 0;
            padding: 1px 6px;
            border-radius: 0 10px 0 10px;
            font-size: 20px;
            color: $color-tomato;
            cursor: pointer;
            text-shadow: none;
            box-shadow: -1px 1px 2px 0px rgba(0,0,0,.3);
            transform: translateZ(0);
        }
        .alert-effect{
            position: fixed;
            display: block;
            bottom: 15px;
            left: 17px;
            height: 36px;
            width: 48px;
            background-color: $color-tomato;
            opacity: 1;
            z-index: -1;
            border-radius: 50%;
            transform: translate3d( 0, 0, 0);
            transition: width 1s cubic-bezier(.3, 0, .4, 1) 0s, 
                        height 1s cubic-bezier(.3, 0, .4, 1) 0s,
                        opacity 1s cubic-bezier(.3, 0, .4, 1) 0s,
                        transform .35s linear .48s;
            &.active { 
                opacity: 0;
                width: 3000px;
                height: 3000px;
                transform: translate3d( -50%, 50%, 0);
                transition: width .52s cubic-bezier(0.4, 0.0, 0.2, 1) 0s, 
                            height .52s cubic-bezier(0.4, 0.0, 0.2, 1) 0s,
                            opacity .52s cubic-bezier(0.4, 0.0, 0.2, 1) 0s;
            }
        }
    }
    
</style>