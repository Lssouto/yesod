<template>
    <section id="login">
        <div class="container container-full">
            <h2 class="text-center">Entrar</h2>
            <div class="box box-rounded">
                <form v-on:submit.prevent="login()" >
                    <div class="input-container">
                        <label>E-mail</label>
                        <input type="text" class="form-control" v-model="credentials.email"/>
                    </div>
                    <div class="input-container">
                        <label>Senha</label>
                        <input type="password" class="form-control" v-model="credentials.password"/>
                    </div>
                    <button class="btn bg-primary">
                        <span class="default">Entrar</span>
                    </button>
                    <br>
                    <router-link :to="{name: 'FgtPwd'}" class="small-font">Esqueci minha senha</router-link>
            
                </form>
            </div>
            
            <div class="text-center">
                <h4>Não tem cadastro?</h4>
                <router-link class="btn bg-primary" :to="{name:'NewUser'}" tag="button">
                    Cadastrar-se
                </router-link>
            </div>
    
        </div>
    </section>
</template>

<script>
import AuthService from '@/services/Authentication'

export default {
    name: "Login",
    data(){
        return{
            credentials: {
                username: '',
                password: '',
                email: ''
            }
        }
    },
    methods: {
        async login(){

            if(!this.validateForm())
                return this.$emit('error',"Por favor, Preencha os campos!")
                
            if(this.credentials.password == "undefined")
                return this.$emit('error',"Senha inválida!")
                
            let response = await AuthService.post(this.credentials) 
            console.log(response);
            this.nextLogin(response);
       
            
            this.credentials = {
                username: '',
                password: '',
                email: ''
            }
           
        },
        verifyPasswordDate(data){

            const clean = data.substr(0,10).split('-');
            const formattedDate = new Date(clean[0],parseInt(clean[1])-1,clean[2]).toISOString()
            const thisDate = new Date().toISOString();

            if( formattedDate > thisDate)
                return true;
            else
                return false;
        },
        validateForm(){
            const credentials = this.credentials;
            if(!!credentials.email && !!credentials.password)
                return true;
            else
                return false;
        },
        nextLogin(response){
            
            if(!response.status) {
                return this.$emit('error',response.message)
            }
            else{
            
                this.$store.dispatch('setToken', "teste")
                
                // const isPasswordDateValid = this.verifyPasswordDate(response.data.dt_pwdExpires)
                let isPasswordDateValid = true
                this.$store.dispatch('setPasswordValidState', isPasswordDateValid)
                console.log(isPasswordDateValid)
                if(!isPasswordDateValid){
                    
                    this.$swal({
                        type: 'warning',
                        title: 'Oops...',
                        text: 'Sua Senha expirou, iremos rediceriona-lo logo. . . ',
                        footer: ''
                    })
                    let self = this;
                    
                    setTimeout(function() {
                        self.$router.push({
                            name: 'Change Password'
                        })
                    }, 1500);
                    
                }
                else{
                    this.$router.push({
                        name: 'Events'
                    });
                }
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