import Api from './Api';
const Url = '/materia';
const isPartialLoader = true;

export default {
    get(){
        return Api.get(Url, isPartialLoader);
    }
}