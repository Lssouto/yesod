<template>
    <section id="login">
        <div class="container container-full">
            <h2 class="text-center">Cadastrar-se</h2>
            <div class="box box-rounded">
                <form v-on:submit.prevent="create()" >
                    <div class="input-container">
                        <label>E-mail</label>
                        <input type="text" class="form-control" v-model="credentials.email"/>
                    </div>
                    <div class="input-container">                    
                        <label>Nome de usuário</label>
                        <input type="text" class="form-control" v-model="credentials.username"/>
                    </div>
                    <button class="btn bg-primary">
                        <span class="default">Cadastrar</span>
                    </button>
                    <br>
                    <a href="#" class="small-font">Esqueci minha senha</a>
            
                </form>
            </div>
            
            <div class="text-center">
                <h4>Já Tem cadastro?</h4>
                <router-link class="btn bg-secundary" :to="{name: 'Login'}" tag="button">
                    Entrar
                </router-link>
            </div>

        </div>
    </section>
</template>

<script>
import UserServ from '@/services/User'

export default {
    name: "NewUser",
    data(){
        return{
            credentials: {
                username: '',
                email: ''
            }
        }
    },
    methods: {
        async create(){

            if(!this.validateForm()){
                return this.$emit('error',"Por favor, Preencha os campos!")
            }
           
            let response = await UserServ.create(this.credentials) 
            console.log(response);
            this.nextCadastro(response);

            this.credentials = {
                username: '',
                password: '',
                email: ''
            }
           
        },
        validateForm(){
            const credentials = this.credentials;
        
            if(!!credentials.email && !!credentials.username)
                return true;
            else
                return false;
        },
        nextCadastro(response){
            if(!response.status){
                return this.$emit('error',response.message)
            }
            else{
                this.$router.push({
                    name: 'Login'
                })
                this.$swal({
                    type: 'info',
                    title: 'Cadastro Feito',
                    text: 'Enviamos sua senha temporária para o seu e-mail.'
                })    
            }
            
        }
    }
}
</script>

<style lang="scss">
#login{
    h2{
        margin-top: 50px;
    }
    .box{
        padding: 20px 45px;
        background-color: $light-gray;
        display: block;
        margin: 20px auto 15px;
        min-width: 100%;
        &:hover{
            box-shadow: 0 6px 6px rgba(0,0,0,.4);
        }
        
        @include media($md,'min'){
            min-width: initial;
            max-width: 50%;
        }
    }
    .input-container{
        margin-top: 14px;
    }
    .small-font{
        font-size: 15px;
    }
    
}

</style>