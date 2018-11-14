import Api from './Api'
const Url = '/usuario'
const isPartialLoader = false;

export default {
    changePassword(user){
        return Api.post(Url + '/changePassword', user, isPartialLoader );
    },
    create(user){
        return Api.post(Url + '/', user, isPartialLoader)
    },
    fgtPassword(user){
        return Api.post(Url + '/fgtPassword', user, isPartialLoader)
    }
   
}
