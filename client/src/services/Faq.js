import Api from './Api';
const Url = '/faq';
const isPartialLoader = true;

export default {
    post(info){
        return Api.post(Url, info, isPartialLoader);
    }
}