<template>
    <div class="dual-list-box">
        <ul class="dualList">
            <li v-for="item in items" 
                :key="item.id" 
                @click="activeItem = item"
                :class="{active: item == activeItem}">
                {{item.nome | firstUpper}}
            </li> 
        </ul>
        <div class="actions text-center">
            <button type="button" class="btn bg-primary" @click="addItem()"> Adicionar </button>
            <button type="button" class="btn bg-primary" @click="addAllItem()"> Adicionar Todos </button>
            <button type="button" class="btn bg-secundary" @click="removeItem()"> Deletar</button>
            <button type="button" class="btn bg-secundary" @click="removeAllItem()"> Deletar Todos </button>
        </div>
        <ul class="dualList">
            <li v-for="sItem in selectedItems" 
                :key="sItem.id" 
                @click="activeItem = sItem"
                :class="{active: sItem == activeItem}">
                {{sItem.nome | firstUpper}}
            </li>
        </ul>
    </div>
</template>
<script>
    export default {
        name: 'dualListBox',
        data() {
            return { 
                selectedItems: [],
                activeItem: {},
                items: [],
            };
        },
        methods: {
            addItem(){
                if(!this.activeItem.id)
                    return;
                const index = this.items.findIndex(item => {
                    return this.activeItem.id == item.id
                });
                if(index == -1)
                    return;
                this.items.splice(index,1);
                this.selectedItems.push(this.activeItem);
                this.outputSelectedItems();
            },
            addAllItem(){
                this.items.forEach(item=>{
                    this.selectedItems.push(item);
                })
                this.items = [];
                this.outputSelectedItems();
            },
            removeItem(){
                if(!this.activeItem.id)
                    return;
                const index = this.selectedItems.findIndex(item => {
                    return this.activeItem == item;
                });
                if(index == -1)
                    return;
                this.selectedItems.splice(index,1);
                this.items.push(this.activeItem);
                this.outputSelectedItems();
            },
            removeAllItem(){
                this.selectedItems.forEach(item=>{
                    this.items.push(item);
                })
                this.selectedItems = [];
                this.outputSelectedItems();
            },
            outputSelectedItems(){
                this.activeItem = {};
                this.$emit('selectedItems', this.selectedItems)
            },
            updateSelectedItems(value){
                this.selectedItems = [];
                if(!value || !value.length)
                    return;
                if(typeof value == "string")
                    value = JSON.parse(value);
                value.forEach(val=>{
                    this.activeItem = val;
                    this.addItem();
                })
            }
        },
        props: [ 
            'initialList',
            'selectedItemsList'
        ],
        watch: {
            'initialList' : {
                deep: true,
                handler : function(value){
                    this.items = JSON.parse(JSON.stringify(value));
                    this.updateSelectedItems(this.selectedItemsList);
                } 
            },
            'selectedItemsList': { 
                deep: true,
                handler: function(value){
                    this.updateSelectedItems(value);
                }
            }
        }
    }
</script>
<style lang="scss">
    .dualList{
        width: 100%;
        height: 80px;
        overflow-y: scroll;
        @extend .shadowbox;
        border-radius: 4px;
        background-color: $white ;
        & > li{
            padding: 8px 15px;
            font-size: 15px;
            cursor: pointer;
            &:not(:last-child){
                border-bottom: 1px dashed $medium-gray;
            }
            &:hover{
                background-color: lighten($light-gray,3%);
            }
            &.active{
                background-color: $primary;
                color: $white;
            }
        }
    }
</style>