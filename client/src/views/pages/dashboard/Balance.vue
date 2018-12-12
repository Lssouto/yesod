<template>
    <div id="balance" class="container">
        <h1>Foca Balance</h1>  
        <div class="media-container">
            Média: 
            <input type="number" class="form-control" v-model="models.media">      
        </div>
        <div class="balance">
            <div class="balance-list">
                <div class="balance-item" v-for="(item, index) in list" :key="item.materia.id">
                    <div class="balance-action-title" @mouseover="toggleRemoveBtn('show', index)" @mouseleave="toggleRemoveBtn('hide', index)">
                        <div @click="showRemoveModal(item.id)" class="btn bg-dark-secundary btn-remove">
                            Remover
                        </div>
                        <div class="balance-item-title" >
                            {{ item.materia.nome | firstUpper}}
                        </div>
                    </div>
                    <balance-nota :min="models.media" :materia="item"></balance-nota>
                </div>
                <div class="addBalance" v-show="states.addBalance">
                    <select v-model="models.materia" class="form-control">
                        <option v-for="materia in materias" :key="materia.id" :value="materia">
                            {{materia.nome | firstUpper}}
                        </option>
                    </select>
                    <button class="btn bg-primary" @click="adicionarBalance()">Salvar</button>
                    <button class="btn bg-error" @click="states.addBalance = false">Cancelar</button>
                </div>
                <div class="balance-add bg-primary" @click="states.addBalance = true" v-show="!states.addBalance">
                    Adicionar
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import MateriaServ from '@/services/Materia'
import BalanceServ from '@/services/Balance'
import BalanceNota from '@/components/dashboard/Balance-nota'
export default {
    name: "Balance",
    data(){
        return{
            list: [],
            materias : [],
            states : {
                addBalance : false,
            },
            models:{
                materia: {},
                nota: {
                    value: null,
                    peso: null
                },
                media : 6
            }
        }
    },
    mounted(){
        this.getMaterias();
        this.getBalance();
    },
    methods:{
        
        async adicionarBalance(){
            let isValid = true;
            for(let i = 0 ; i < this.list.length; i++){
                if(this.list[i].materia == this.models.materia)
                    isValid = false;
            }
            if(!isValid || !this.models.materia.nome)
                return ;

            let response = (await BalanceServ.post({
                idMateria: this.models.materia.id,
                descricao: JSON.stringify([]),
                notaMinima: this.models.media,
                idUser: 0
            }));

            if(response.status){
                console.log('Ok Request')
                this.getBalance();
            }
            else
                console.log('Error on request')

            this.models.materia = {};
            this.states.addBalance = false;
        },
        async getMaterias(){
            this.materias = (await MateriaServ.get()).data;
        },
        async getBalance(){
            const res = (await BalanceServ.get())
            if(res.status){
                this.list = [];
                if(res.data.length)
                    res.data.forEach(d=>{
                        this.list.push({
                            id: d.id,
                            materia: this.materias.find(mat=>{
                                return mat.id == d.idMateria;
                            }),
                            notas: JSON.parse(d.descricao),
                            notaMinima: d.notaMinima
                        })    
                    })
            } else{
                console.log('Não foi possível carregar')
            }
        },
        showRemoveModal(id){
            this.$swal({
                type:'info',
                title: '<h2>Remover Balance?</h2>',
                confirmButtonText:
                'Remover',
                showCancelButton: true,
                cancelButtonText: 
                'Cancelar'
            }).then( async result =>{
                if(result.value){
                    let res = await BalanceServ.del(id)
                    this.getBalance();
                } 
            })
        },
        toggleRemoveBtn(status, index){
            index++;
            const el = document.querySelector('.balance-list .balance-item:nth-child('+index+') > .balance-action-title > .btn-remove');
            if(!el)
                return
            if (status == 'show') {
                el.classList.add('btn-remove-show');
            } else {
                el.classList.remove('btn-remove-show');
            }
        }
    },
    components: {
        BalanceNota
    }
}
</script>
<style lang="scss">
#balance{
    .media-container{
        width: 120px;
    }
    .balance{
        &-list{
            margin-top: 40px;
            @extend .shadowbox;
            border-radius: 6px;
        }
        
        &-item{
            
            @include flex-align(0 1 auto);
            border-bottom: 2px solid $black;
            background-color: $white;
            
            &-title{
                padding: 8px 12px;
                background-color: $orange;
                color: $white;
                text-align: center;
                width: 100%;
            }
            .nota-add{
                border-radius: 50%;
                margin: 0;
                width: 35px;
                height: 35px;
                padding: 4px 0 0 0;
                margin-top: 4px;
                margin-left: 5px;
                text-align: center;
            }
            .balance-action-title{
                position: relative;
                overflow-x: hidden;
                @include flex-align(1 1 auto);
                @include media($sm,'min'){
                    flex: 1 1 20%;
                }
                .btn-remove{
                    position: absolute;
                    top: 0;
                    left: -100%;
                    transform: translate3d(0,0,0);
                    cursor: pointer;
                    z-index: 10;
                    margin: 0;
                    border-radius: 0px;
                    box-shadow: none;
                    width: 100%;
                    padding-left: 0;
                    padding-right: 0;
                    min-height: 44px;
                    @include animation-spd(.25s);
                    &-show{
                        @include animation-spd(.35s);
                        transform: translate3d(100%,0,0);
                    }
                }
            }
        }
        &-add{
            text-align: center;
            text-transform: uppercase;
            font-weight: bolder;
            padding: 10px 0;
            @include animation-spd(.22s);
            &.active{
                transform: translate3d(100%, 0, 0);
            }
        }
        .addBalance{
            @include flex-align(0 1 auto);
            .form-control{
                border-radius: 0;
                margin: 3px 3px 3px 0;
            }
            .btn{
                box-shadow: none;
                border-radius: 0;
                margin: 0;
                flex: 1 1 50%;
                font-size: 14px;
                text-transform: uppercase;
            }
        }
    }
} 
</style>