<template>
    <div id="contato" class="container container-full">
        <div class="box box-rounded">
            <h2 class="page-title">Fale Conosco</h2>
            <form v-on:submit.prevent="contato()">
                <div class="input-container">
                    <label class="input-container">Nome</label>
                    <input type="text" name="" class="form-control" />
                </div>
                <div class="input-container">
                    <label class="input-container">Assunto</label>
                    <input type="text" name="" class="form-control" />
                </div>
                <div class="input-container">
                    <label class="input-container">Mensagem</label>
                    <textarea name="" class="form-control"> </textarea>
                </div>
                <input type="submit" value="Submit" class="btn bg-primary"/>
            </form>
        </div>
    </div>
</template>

<script>


export default {
    name: "Contato",
    methods: {
        contato(){
            
        }
    }
}
</script>

<style lang="scss">
#contato{
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
}
</style>