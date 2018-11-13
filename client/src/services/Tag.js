import Api from './Api';
const Url = '/tag';
const isPartialLoader = true;

export default {
    get(args){
        if(args)
            return Api.get(Url+'/'+args, isPartialLoader);
        else
            return Api.get(Url, isPartialLoader);
    }
}