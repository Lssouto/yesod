<template>
    <section id="login">
        <div class="container container-full">
            <h2 class="text-center">Esqueci a senha</h2>
            <div class="box box-rounded">
                <form v-on:submit.prevent="recuperar()" >
                    <div class="input-container">
                        <label>E-mail</label>
                        <input type="text" class="form-control" v-model="email"/>
                    </div>

                    <button class="btn bg-primary">
                        <span class="default">Recuperar</span>
                    </button>
            
                </form>
            </div>

        </div>
    </section>
</template>

<script>
import UserServ from '@/services/User'
export default {
    name: "Login",
    data(){
        return{
            email: ''
        }
    },
    methods: {
        async recuperar(){

            if(!this.email){
                return this.$emit('error',"Por favor, Preencha os campos!")
            }
            let response = (await UserServ.fgtPassword({
                email : this.email
            }));

            this.nextRecuperar(response)
            this.email = ''
           
        },
        nextRecuperar(response){
            
            if(!response.status) {
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