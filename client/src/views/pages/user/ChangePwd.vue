<template>
    <section id="changePwd">
        <div class="box box-rounded">
            <h2 class="page-title">Trocar a senha</h2>
            <form v-on:submit.prevent="change()" >
                <div class="input-container">                    
                    <label class="input-container">Senha atual</label>
                    <input type="text" class="form-control" v-model="credentials.password"/>
                </div>
                <div class="input-container">                    
                    <label class="input-container">Senha nova</label>
                    <input type="text" class="form-control" v-model="credentials.newPassword"/>
                </div>
                <div class="input-container">                    
                    <label class="input-container">Repita a senha nova</label>
                    <input type="text" class="form-control" v-model="credentials.newPasswordRe"/>
                    <div class="password-strength" :data-status="passwordPower.status">
                        {{passwordPower.msg}}    
                    </div>
                </div>
                <div>
                    <input type="submit" value="Alterar" class="btn bg-primary"/>
                </div>
            </form>
        </div>
    </section>
</template>
<script>
import UserServ from '@/services/User'

export default{
    name: 'ChangePassword',
    data(){
        return{
            credentials : {
                password: '',
                newPassword: '',
                newPasswordRe: ''
            },
            regExp: {
                lowerCaseLetter: new RegExp('[a-z]',''),
                upperCaseLetter: new RegExp('[A-Z]',''),
                number: new RegExp('[0-9]',''),
                specialCharacter: new RegExp('[!@#$&*]','')
            }
        }
    },
    methods: {
        async change(){
            if(
                this.credentials.newPassword !== this.credentials.newPasswordRe
                ||  ( 
                        !this.credentials.newPassword
                        && !this.credentials.Password
                        && !this.credentials.newPasswordRe
                    )
                ||  (
                        this.passwordPower.status != 6
                    )
            ){
                this.$swal({
                    type: 'error',
                    title: 'Oops...',
                    text: 'Campos inválidos'
                })
            }
            else{
                this.credentials.user = this.$store.state.user;
                let response = await UserServ.changePassword(this.credentials);
                 
                if(response.status){
                    this.$store.dispatch('setPasswordValidState', true)
                    this.$swal({
                        type: 'success',
                        title: 'Senha alterada',
                    })
                    this.$router.push({
                        name: 'Events'
                    })
                }
                else{
                    this.$swal({
                        type: 'error',
                        title: 'Oops...',
                        text: ''
                    })
                }
            }
        }
    },
    computed: {
        passwordPower: function (){
            let pwd = this.credentials.newPassword;
            let isValid = true;
            if(pwd == '')
                return {
                    status: 0,
                    msg : ''
                };
            if(!(this.regExp['lowerCaseLetter'].exec(pwd))){
                isValid = false;
                return {
                    status: 1,
                    msg : "Pelo menos um carácter minusculo."
                }
            }
            if(!this.regExp['upperCaseLetter'].exec(pwd)){
                isValid = false;
                return {
                    status: 2,
                    msg: "Pelo menos um carácter maiúsculo."
                }
            } 
            if(!this.regExp['number'].exec(pwd)){
                isValid = false;
                return {
                    status: 3,
                    msg: "Pelo menos um número."
                }
            } 
            if(!this.regExp['specialCharacter'].exec(pwd)){
                isValid = false;
                return {
                    status: 4,
                    msg: "Pelo menos um carácter especial."
                }
            }
            if(pwd.length < 8){
                isValid = false;
                return {
                    status: 5,
                    msg: "Minimo de caracteres é 8"
                }
            }
            if(isValid){
                return {
                    status: 6,
                    msg: ""
                };
            }
        } 
    }
}
</script>

<style lang="scss">
#changePwd{
    .box{
        padding: 20px 45px;
        background-color: $light-gray;
        display: block;
        margin: 70px auto 15px;
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
        margin-top: 8px;
    }
    .small-font{
        font-size: 15px;
    }
    .password-strength{
        @extend .fast-e;
        margin-top: 5px;
        padding: 5px 15px;
        font-weight: bolder;
        font-size: 18px;
        display: block;
        position: relative;
        min-height: 37px;
        &[data-status]{
            &:before{
                @include pseudo(absolute,block);
                top: 0;
                left: 0;
                width: 0;
                height: 3px;
                @extend .fast-e;
            }
        }
        &[data-status="1"],&[data-status="2"],&[data-status="3"]{
            color: $error;
            &:before{
                background-color: $error;
            }
        }
        &[data-status="1"]{
            &:before{
                width: 17%;
            }
        }
        &[data-status="2"]{
            &:before{
                width: 34%;
            }
        }
        &[data-status="3"]{
            &:before{
                width: 51%;
            }
        }
        &[data-status="4"]{
            color: darken($warning,15%);
            &:before{
                width: 67%;
                background-color: darken($warning,15%);
            }
        }
        &[data-status="5"]{
            color: $primary;
                &:before{
                    width: 84%;
                    background-color: $primary;
                }
        }
        &[data-status="6"]{
            &:before{
                width: 100%;
                background-color: $secundary;
            }
        }
    }
}    
</style>