<template>
    <section id="addEvent">
        <div class="container container-full">
        <h2 class="titulo">Criar Evento</h2> 
            <div class="box box-rounded">
                <form v-on:submit.prevent="addEvent()">
                    <div class="input-container linha-1">
                        <label class="topo">
                            Data do Evento*
                        </label>
                        <Datepicker 
                            lang="pt-br" 
                            v-model="evento.dtEvento" 
                            :time-picker-options="timePickerOptions" 
                            type="datetime"
                            :confirm="true"
                            :minute-step="5"
                            format="dd-MM-yyyy HH:mm:ss"
                        />
                    </div>
                    <div class="text-center">
                        <input name="type" type="radio" value="prova" v-model="evento.type" /> Prova*
                        <input name="type" type="radio" value="estudo" v-model="evento.type" /> Estudo*
                    </div>
                    <div class="input-container">
                        <label>Título do Evento*
                            <input type="text" class="form-control" v-model="evento.titulo"/>
                        </label>
                    </div>
                    <div class="input-container">
                        <label>Descrição do Evento*
                            <textarea class="form-control" v-model="evento.descricao"/>
                        </label>
                    </div>
                    <div class="input-container">
                        <label>Matéria*
                            <select class="form-control" v-model="evento.materia">
                                <option v-for="materia in materias" :key="materia.id" :value="materia">{{materia.nome | firstUpper }}</option>
                            </select>
                        </label>
                    </div>
                    <label>Assuntos</label>
                    <div class="input-container">
                        <dual-list-box :initialList="tags" @selectedItems="putSelectedTags"/>
                    </div>
                    <div class="text-center">
                        <input type="submit" value="Salvar" class="btn bg-primary"/>
                    </div>
                </form>
            </div>
        </div>
    </section>
</template>

<script>
import Datepicker from 'vue2-datepicker';
import EventService from '@/services/Event';
import MateriaServ from '@/services/Materia';
import TagServ from '@/services/Tag';
import DualListBox from '@/components/dual-list-box';
export default{
    name: 'Event',
    data(){
        return{
            evento: {
                dtEvento: null,
                titulo: null,
                descricao: null,
                materia: null,
                // tag: '',
                type: 'prova',
            },
            materias : [],
            tags: [],
            selectedTags: [],
            activeTag: {},
            timePickerOptions: {
                start: '00:00',
                step: '00:30',
                end: '23:30'
            }
        }
    }, 
    async mounted(){
        this.materias = (await MateriaServ.get()).data;
    },
    methods: {
        async addEvent(){
            this.evento.tags = this.selectedTags;
            const event = this.evento;
            
            const isValid = Object.keys(event).every(item=>{
                return !!event[item];
            })
            
            if(!isValid){
                this.error('Campos Obrigatórios')
                return;
            }
            
            event.idMateria = event.materia.id;
            event.tags = JSON.stringify(event.tags);
            event.idUser = 0;
            
            let response = await EventService.post(event);
            
            console.log(response)
            
            if(response.status){
                this.$swal({
                    type:'success',
                    title: '<h2>Evento Adicionado</h2>',
                    confirmButtonText:
                    'Finalizar',
                    showCancelButton: true,
                    cancelButtonText: 
                    'Continuar adicionando'
                }).then(result =>{
                  if(result.value)
                    this.$router.push({
                        name: 'Events'
                    })
                    else
                        this.evento = { dtEvento: null, titulo: null, descricao: null, materia: null, type: 'prova' }
                })
            }
            else{
                this.error(response.message);
            }
        },
        putSelectedTags(val){
            this.selectedTags = val;
        }
    },
    watch : {
        'evento.materia' : {
            handler : async function(value){
                this.selectedTags = [];
                console.log(value);
                if(!value)
                    return
                this.tags = (await TagServ.get(value.id)).data;
            }
        }
    },
    components: {
        Datepicker,
        DualListBox
    }
}
</script>
<style lang = "scss">
#addEvent{
    label{
        display: block; 
    }
    .box{
        padding: 20px 45px;
        background-color: $light-gray;
        display: block;
        margin: 30px auto 15px;
        min-width: 100%;
        &:hover{
            box-shadow: 0 6px 6px rgba(0,0,0,.4);
        }
        
        @include media($md,'min'){
            min-width: initial;
            max-width: 85%;
        }
    }
    .form-control{
        padding-top: 10px;
    }
    .block{
        display: block;
    }
    .topo{
        display: inline-block !important;
    }
    .m-l-20{
        margin-left: 20px;
    }
    .titulo{
        margin-top:30px;
        text-align: center
    }
    .linha-1{
        text-align: center;
        label{
            text-align: left !important;
            margin-right: 30px;
        }
    }
}

</style>
