import Api from './Api';
const Url = '/balance';
const isPartialLoader = false;

export default {
    post(balance){
        return Api.post(Url, balance, isPartialLoader);
    },
    get(){
        return Api.get(Url, isPartialLoader);
    },
    put(balance){
        return Api.put(Url, balance, isPartialLoader)
    }
}