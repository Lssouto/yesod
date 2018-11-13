<template>
    <div class="pomodoro-timer">
        <div class="pomodoro-timer-value" v-if="timerCounter > 0">
            {{ timerValue }}
        </div>
    </div>
</template>
<script>
    export default {
        name: 'pomodoro-time',
        data(){
            return {
                timerCounter: 0,
                timerInterval: null
            };
        },
        beforeDestroy(){
          if(this.timerInterval){
              clearInterval(this.timerInterval)
          }  
        },
        methods: {
            start(val){
                this.timerCounter = val * 60;
                if (!this.timerInterval) {
    				  this.timerInterval = setInterval( () => {
    						if (this.timerCounter > 0) {
    							 this.timerCounter--
    						} else {
    						    console.log('clearing interval')
    							 clearInterval(this.timerInterval)
    							 this.reset();
    							 this.$emit('finished')
    						}
    				  }, 1000 )
    			 }
            },
            reset(){
                this.timerInterval = null;
            }
        },
        props: [
            'time'
        ],
        watch: {
            'time': {
                handler: function(val){
                    if(val && !this.timerInterval){ 
                        console.log("chegou", val)
                        this.start(val)
                    }
                    else
                        return;
                }
            }
        },
        computed: {
            timerValue: function () {
                if(!this.timerCounter)
                    return '';
                    
                let time = this.timerCounter / 60
                let minutes = parseInt(time)
                let secondes = Math.round((time - minutes) * 60)
                if (minutes < 10) {
                	minutes = "0" + minutes
                }
                if (secondes < 10) {
                	secondes = "0" + secondes
                }
                return minutes + ":" + secondes
            }
        }
    }
</script>
<style lang="scss">
    .pomodoro-timer-value {
        opacity: .15;
        @extend .slow-e;
        position: absolute;
        right: -50px;
        bottom: 13px;
    }
</style>