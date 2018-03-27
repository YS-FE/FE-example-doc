# 组件异步加载


## 注册组件

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
 ```

 
 ## 使用 vue-router时 路由组件异步加载

 ```js
 const xxx = () => import ('./xxx')
 const yyy = (resolve) => require(['./yyy'], resolve)
 ```