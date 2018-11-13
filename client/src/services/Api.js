import store from '../store/store'
import VM from '@/main.js'

const config = {
    ApiUrl : 'http://' + window.location.hostname + '',
    errorHandler(message){
        VM.$swal({
            type: 'error',
            title: 'Ops ...',
            text: message + ' (^_−)☆'
        })
    }
}

const connect = (url, options, isPartialLoader)=>{
    // console.log(VM)
    if(!!VM)
        VM.$children[0].$refs['app-loader'].show(isPartialLoader);
        
    if(!options)

        return  fetch(config.ApiUrl + url)
        .then(response=> { 
            VM.$children[0].$refs['app-loader'].remove(); 
            return response.json();
        })
        .catch(err => {
            VM.$children[0].$refs['app-loader'].remove(); 
            config.errorHandler('Aconteceu algo,')
            
            return console.log(err);
        })
        
        else
            return  fetch(config.ApiUrl + url,options)
            .then(response=> { 
                VM.$children[0].$refs['app-loader'].remove();  
                return response.json();
            })
            .catch(err => { 
                VM.$children[0].$refs['app-loader'].remove();  
                config.errorHandler('Aconteceu algo,')
                
                return console.log(err);
            })
}
export default{
    get(url, isPartialLoader){
        return connect(url,{
            method : 'get',
            headers: new Headers({
                'Content-Type': 'application/json',
                Accept: 'application/json',
                Authorization : store.state.token
            })
        }, isPartialLoader);
    },
    post(url, data, isPartialLoader){
        return connect(url,{
                method: 'post', 
                body: JSON.stringify(data),
                headers: new Headers({
                    'Content-Type': 'application/json',
                    Accept: 'application/json',
                    Authorization : store.state.token
                })
            }, isPartialLoader)
    },
    put(url, data, isPartialLoader){
        return connect(url + '/' + data.id,{
            method: "put",
            body: JSON.stringify(data),
            headers: new Headers({
                'Content-Type': 'application/json',
                Accept: 'application/json',
                Authorization : store.state.token
            })
        }, isPartialLoader)
    },
    del(url, data, isPartialLoader){
        return connect ( url + '/' + data, {
            method: "delete",
            headers: new Headers({
                'Content-Type': 'application/json',
                Accept: 'application/json',
                Authorization : store.state.token
            })
        }, isPartialLoader)
    }
}