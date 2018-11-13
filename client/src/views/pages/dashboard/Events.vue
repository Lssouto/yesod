<template>
    <div id="events">
        <div class="container">   
            <h2>Eventos Cadastrados</h2>
            <div class="">
                <router-link :to="{ name : 'AddEvent'}" class="btn bg-primary btnNovoEvento">Novo Evento</router-link>
            </div>

            <div class="events-logger">
                <div class="logger-nav">
                    <div class="logger-header">
                        2018
                    </div>

                    <ul class="logger-body">
                        <li v-for="event in eventsData" :key="event.name" :disabled="!event.data.length" @click="changeDay(event.name)" :class="{active : event.active}">
                            {{event.name}}
                        </li>
                    </ul>

                </div>

                <ul class="logger-day">
                    <li>
                        <events-day :days="eventDay" @updateEventValue="updateEventValue" />
                    </li>
                </ul>

            </div>    
        </div>
    </div>
</template>

<script>
import EventsDay from '@/components/dashboard/Events-day'
import EventServ from '@/services/Event'
export default {
    name: "Events",
    data(){
        return{
            eventsData: [
                {name : "Janeiro",data : []},
                {name : "Fevereiro",data : []},
                {name : "Março",data : []},
                {name : "Abril",data : []},
                {name : "Maio",data : []},
                {name : "Junho",data : []},
                {name : "Julho",data : []},
                {name : "Agosto",data : []},
                {name : "Setembro",data : []},
                {name : "Outubro",data : []},
                {name : "Novembro",data : []},
                {name : "Dezembro",data : []},
            ],
            eventDay: {}
        }
    },
    components: {
        EventsDay
    },
    mounted(){
        this.getEvents();
    },
    methods:{
        changeDay(name){
            const newMonth = (this.eventsData).find(event=>{
                return event.name == name;
            }).data
            if(newMonth.length){
                this.eventDay = newMonth;
                this.setActiveMonth(name)
            }
        },
        setActiveMonth(name){
            this.clearActiveMonth();
            let activePosition = (this.eventsData).findIndex(event =>{
                return event.name == name;
            })

            if(activePosition == -1)
                console.log('Not Found Active')
            else{
                this.eventsData[activePosition]['active'] = true;
            }            
        },
        clearActiveMonth(){
            (this.eventsData).forEach(event => {
                event['active'] = false;
            });
        },
        async getEvents(){
            let response = (await EventServ.get()).data;
            console.log(response);
            this.eventsData = response;
            for(let i = 0; i < this.eventsData.length; i++){
                if(response[i].data.length){
                    this.eventDay = response[i].data;
                    this.eventsData[i]['active'] = true;
                    break;
                }
            }
        },
        updateEventValue(event){
            this.$emit('updateEventValue', event)
        }
    }
}
</script>

<style lang="scss">
#events{
    padding-top: 25px;
    .events{
        &-logger{
            @include flex-align(1 1 auto);
            width: 100%;
            align-items: flex-start;
            margin: 45px 0;
            .logger{
                &-header{
                    border-bottom: 2px solid $white;
                    padding: 8px 25px;
                    background-color: $orange;
                }
                &-nav{
                    text-align: center;
                    flex: 0 1 auto;
                    color: $white;  
                }
                &-body{
                    & > li{
                        padding: 8px 25px;
                        background-color: $orange;
                        cursor: pointer;
                        @extend .fast-e;
                        &:not(:last-child){
                            border-bottom: 1px solid $light-gray;
                        }
                        &[disabled]{
                            cursor: default;
                            color: rgba($white,.4);
                            background-color: rgba($orange,.6);
                        }
                        &.active{
                            background-color: darken($primary,10%);
                        }
                    }
                }
            }
            @include media($sm,'max'){
                .logger{
                    &-header{
                        display: inline-block;
                        width: 100%;
                    }
                    &-body{
                        display:  flex;
                        flex-wrap: wrap;
                        & > li{
                            padding: 8px 0;
                            flex: 1 1 33%;
                        }
                    }
                }
            }
        }   
    }
    .btnNovoEvento{
        text-align: right;
    }

    .form-control{
        width: 20%;
        height: 30px;
        font-size: 13px;
        margin-top: 20px;
    }
    label{
        display: block;
    }
}
</style>
