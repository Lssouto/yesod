<template>
    <footer id="site">
        <!--<div class="footer-top">-->
        <!--    <div class="container">-->
        <!--        <h2>-->
        <!--            E ai, vamos focar nos estudos juntos ? -->
        <!--        </h2>-->
        <!--    </div>-->
        <!--</div>-->
        <div class="footer-bottom">
            <div class="container">
                <p>Foca Team - Todos os direitos reservados.</p>
            </div>
        </div>
    </footer>
</template>
<script>
    export default { 
        name: 'rodape'
    }
</script>
<style lang="scss">
    footer#site{
        margin-top: 35px;
        color: $white;
        .footer-top{
            background-color: $dark-secundary;       
            padding: 12px 0;
            h2 {
                text-align: center;
                margin: 0;
                width: 100%;
            }
        }
        .footer-bottom{
            background-color: darken($dark-secundary, 8%);
            padding: 8px 0;
            p {
                text-align: right;
                font-size: 13px;
                margin: 0;
                width: 100%;
            }
        }
    }
</style>