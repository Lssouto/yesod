import Api from './Api';
const Url = '/event';
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
    }
}