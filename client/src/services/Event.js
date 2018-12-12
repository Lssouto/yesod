import Api from './Api';
const Url = '/evento';
const isPartialLoader = false;

export default {
    post(evento){
        return Api.post(Url, evento, isPartialLoader);
    },
    get(){
        return Api.get(Url, isPartialLoader);
    },
    getOne(id){
        return Api.get(Url+'/'+id, isPartialLoader)
    },
    put(event){
        return Api.put(Url, event, isPartialLoader)
    },
    del(id) {
        return Api.del(Url, id, isPartialLoader ) 
    }
}