<template>
    <div class="event-day">
         <ul>
            <li v-for="day in orderedDays" :key="day.id">
                <div class="day-title">
                    {{day.titulo}}
                </div>
                <p class="day-desc">
                    {{day.descricao}}
                </p>
                <div class="day-data">
                    {{day.dtEvento | dateformat}}
                </div>
                <!--<div class="day-materia">-->
                <!--    {{day.idMateria}}-->
                <!--</div>-->
                <ul class="tags-list">
                    <li v-for="tag in day.dsAssunto" :key="tag.id">
                        <input type="checkbox" disabled> {{tag.nome | firstUpper}}
                    </li>
                </ul>
                <div class="btn-learning">
                    <button @click="navigateTo({ name : 'PutEvent', params : {idEvent: day.id } }, day)" class="btn bg-warning">Editar</button>
                    <button @click="navigateTo({ name : 'Learning', params : {idEvent: day.id } }, day)" class="btn bg-primary">Learning</button>
                </div>
            </li>
        </ul> 
    </div>
</template>
<script>
export default {
    name: 'Events-day',
    props: [
        'days'
    ],
    computed : {
        orderedDays(){
            if(!this.days.length)
                return [];
            return this.days.sort((v1,v2)=>{
                return new Date(v1.dtEvento).getTime() - new Date(v2.dtEvento).getTime();
            })
        }
    },
    methods: {
        navigateTo(route, event){
            this.$emit('updateEventValue', event)
            this.$router.push(route);
        }
    }
}
</script>
<style lang="scss">
.event-day{
    
    & > ul > li{
        position: relative;
        padding:  15px 25px;
        background-color: lighten($light-gray,4%);
        margin-bottom: 2px;
        cursor: pointer;
        @extend .slow-e;
        &:not(:last-child):after{
            content: '';
            position: absolute;
            display: block;
            height: 2px;
            width: 33%;
            bottom: -2px;
            right: 0;
            border-bottom: 1px dashed $medium-gray;    
        }
        &:hover{
            background-color: $light-gray;
        }
    }
    .day{
        &-title{
            font-size: 24px;
            font-weight: bolder;
            display: block;
        }
        &-data{
            position: absolute;
            top: 15px;
            right: 25px;
            color: $secundary;
            font-size: 12px;
            font-size: 16px;
        }
        &-desc{
            word-wrap: break-word;
            word-break: break-all;
        }
    }  
    .tags-list{
        & > li {
            display: inline-block;
            border-radius: 4px; 
            margin: 8px;
            border: 1px solid $light-gray;
            padding: 5px 10px;
            background-color: $white;
            input[type="checkbox"]{
                margin-right: 8px;
            }
        }
    }
    .btn-learning{
        position: absolute;
        top: 85px;
        right: 25px;
        /*font-size: 12px;*/
        /*font-size: 16px;*/
    }
}

</style>

