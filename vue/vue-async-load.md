
```js
//全局组件
Vue.component('async-example', function (resolve, reject) {
    axios.get('/xxx').then(data => {
     //data是个对象 {template: `<h1>sgsgsg</h1>`}
     resolve(data); 
    })
 })
 
 //局部组件
 new Vue({
     ....,
     components: {
         xxx: function(resolve, reject){
               axios.get('/xxx').then(data => {
            //data是个对象 {template: `<h1>sgsgsg</h1>`}
            
             resolve(data); //resolve(Vue.extend(data)也可以
            })
         }
     }
 })

 
 //使用webpack实现异步加载
 const xxx = () => import ('./xxx')
 const yyy = (resolve) => require(['./yyy'], resolve)
 ```