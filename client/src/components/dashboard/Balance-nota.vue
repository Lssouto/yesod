<template>
    <div class="balance-nota-list">
        <b-dropdown 
            :text="'Media: ' + media" 
            class="dropdown-media"
            :class="[
                {'bad': media < min-1},
                {'ok': media > min},
                {'warning' : media >= min-1 && media <= min}]"
                ref="mediaTooltip">
            <b-dropdown-item    
                @click="isPonderada = false"
                :class="{'active': !isPonderada}">
                Aritmética
            </b-dropdown-item>
            <b-dropdown-item 
                @click="isPonderada = true"
                :class="{'active': isPonderada}">
                Ponderada
            </b-dropdown-item>
        </b-dropdown>
        <b-tooltip :target="() => $refs.mediaTooltip">
            <div class="tooltip-box bg-main" :style="boxStyle">
            </div> - Tudo OK<br>
            <div class="tooltip-box bg-warning" :style="boxStyle"></div> - Cuidado <br>
            <div class="tooltip-box bg-error" :style="boxStyle"></div> - Vish . . .
        </b-tooltip>

        <div    class="nota-item" 
                v-for="nota in materia.notas" 
                :key="nota.id" 
                @click=" putState = true;putValue = nota " 
                :class="{'bg-warning' : (isPonderada && !nota.peso)}">
            {{nota.value}}
            
        </div> 
        <div class="nota-add btn bg-secundary" @click="addNota = true" v-show="!addNota">
            +
        </div>
        
        <div class="adicionarNota" v-show="addNota">
            <input  type="number" 
                    class="form-control add-nota" 
                    v-model="models.nota.value" 
                    placeholder="Nota"
                    min="0">

            <input  type="number" 
                    class="form-control add-pseo" 
                    v-model="models.nota.peso" 
                    placeholder="Peso"
                    max="100"
                    min="0"
                    :disabled="!isPonderada">

            <button class="btn bg-primary" @click="adicionarNota()">Salvar</button>
            <button class="btn bg-error" @click="addNota = false">Cancelar</button>
        </div>
        <div class="updateNota" v-show="putState">
            <button class="btn bg-primary"  @click="atualizarNota()">Atualizar</button>
            <button class="btn bg-error" @click="removerNota()">Remover</button>
            <button class="btn bg-warning" @click="putState = false">Cancelar</button>
        </div>
    </div>
</template>

<script>
import BalanceServ from '@/services/Balance';

export default {
    name : 'balanceNota',
    data(){
        return{
            addNota : false,
            putState : false,
            isPonderada: true,
            putValue : {
                id: null,
                value: null,
                peso: null
            },
            models: {
                nota : {
                    value : null,
                    peso : null
                }
            },
            boxStyle:{
                height: '10px',
                width: '10px',
                display: 'inline-block'
            }
        }
    },
    props: [
        'min',
        'materia',
    ],
    methods : {
        adicionarNota(){
            
            if(!this.validateFields())
                return;
           
            if(!this.putState)
                this.materia.notas.push({
                    id: (this.materia.notas.length) ? this.materia.notas[this.materia.notas.length - 1].id + 1 : 0,
                    value : this.models.nota.value,
                    peso : (!this.models.nota.peso) ? 0 : this.models.nota.peso
                })
            
            else{
                let putIndex = this.materia.notas.findIndex(n=>{
                    return n.id == this.putValue.id
                })
                this.materia.notas[putIndex].peso = this.models.nota.peso;
                this.materia.notas[putIndex].value = this.models.nota.value;
                
            }

            this.models.nota = {
                value : null,
                peso : null
            }

            this.putState = false;
            this.addNota = false;
            this.putNota();
        },
        atualizarNota(){
            
            this.models.nota.value = this.putValue.value;
            this.models.nota.peso = this.putValue.peso;
            this.addNota = true;
        },
        removerNota(){
            this.materia.notas.splice(this.putValue.id,1);
            this.putState = false;
            this.putNota();
        },
        validateFields(){
            if(!this.models.nota.value)
                return false;
            if(this.isPonderada && !this.models.nota.peso)
                return false;
            return true;
        },
        async putNota(){
            console.log('Materia',this.materia);
            this.materia.idUser = 0;
            this.materia.idMateria = this.materia.materia.id;
            this.materia.descricao = JSON.stringify(this.materia.notas);
            let response = (await BalanceServ.put(this.materia));
            
            if(response.status){
                console.log('ok')
            }
            else{
                console.log('fail')
            }
        }
        
    },
    computed: {
        media(){
            let media = 0;

            if(this.materia.notas && this.materia.notas.length)
                if(this.isPonderada)
                    this.materia.notas.forEach(n => {
                        media += (n.value * (n.peso/10));
                    });
                else{
                    this.materia.notas.forEach(n => {
                        media += parseInt(n.value);
                    });
                    media /= this.materia.notas.length;
                }

            return Math.round(media * 100) / 100;
        }
    }
}
</script>

<style lang="scss">
.balance{
    &-nota-list{
        display: flex;
        flex-wrap: nowrap;
        position: relative;
        width: 100%;
        & > *{
            flex: 0 1 auto;
        }
        .nota-item,.nota-media{
            padding: 10px;
            border-right: 1px solid $medium-gray;
            cursor: pointer;
        }

        .dropdown-media{

            &.warning .dropdown-toggle{
                color: $white;
                background-color: $warning;
            }
            &.bad .dropdown-toggle{
                color: $white;
                background-color: $error;
            }
            &.ok .dropdown-toggle{
                color: $white;
                background-color: $primary;
            }
            .dropdown-toggle{
                box-shadow: none;
                border-radius: 0;
                border: 0px;
                margin: 0;
                font-size: 16px;
                padding-left: 15px;
                padding-right: 15px;
            }
            .active,.active:hover,.active:active,.active:focus{
                background-color: $primary;
            }
            
        }
        
        .adicionarNota{
            position: absolute;
            @include flex-align(0 1 50%);
            background-color: $white;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            z-index: 10;
            .form-control{
                margin: 0;
                border-radius: 0px;
                @include input-placeholder{
                    font-size: 14px;
                    opacity: .5;
                }
                @include media($md,'min'){
                    margin: 3px;
                }
            }
            .btn{
                box-shadow: none;
                border-radius: 0;
                margin: 0;
                flex: 1 1 50%;
                font-size: 14px;
                text-transform: uppercase;
                @include media($sm,'max'){
                    min-height: 40px;
                }
            }
        }
        .updateNota{
            position: absolute;
            @include flex-align(0 1 50%);
            background-color: $white;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            z-index: 5;
            .btn{
                box-shadow: none;
                border-radius: 0;
                margin: 0;
                flex: 1 1 50%;
                font-size: 14px;
                text-transform: uppercase;
                @include media($sm,'max'){
                    min-height: 40px;
                }
            }
        }
    }
}
</style>


