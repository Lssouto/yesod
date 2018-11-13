import Api from './Api'
const Url = '/user'
const isPartialLoader = false;

export default {
    changePassword(user){
        return Api.post(Url + '/changePassword', user, isPartialLoader );
    },
    create(user){
        return Api.post(Url + '/new', user, isPartialLoader)
    },
    fgtPassword(user){
        return Api.post(Url + '/fgtPassword', user, isPartialLoader)
    }
   
}
