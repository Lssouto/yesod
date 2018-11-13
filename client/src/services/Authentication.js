import Api from './Api';
const AuthUrl = '/auth';
const isPartialLoader = false;

export default {
    get(){
        return Api.get(AuthUrl, isPartialLoader);
    },
    post(credentials){
        return Api.post(AuthUrl, credentials, isPartialLoader );
    },
    logout(){
        return Api.get(AuthUrl + '/logout', isPartialLoader)
    }
}