
## redux模块使用

```js
封装的redux中的 applyMiddleware使用
import {createStore, combineReducers, applyMiddleware} from 'redux';
import yyy  from 'yyy'
import zzz from 'zzz'

let store = createStore(xxx, applyMiddleware(yyy, zzz));
```


## 手动实现

```js

 /*
 手动实现 middleware
 middleware: 介于 action 和 reducer之间的操作
 并封装 applyMiddleware方法，引入中间件
 **/
/**
 * 
 * @param {Object} store 
 * @param {Function} next 当前的store.dispatch
 * @param {Object} action 传递给dispatch的action
 */
 const logger = store => next => action => {
     let ret = next(action);
     console.log(store.getState());
     return ret;
 }

 /*
 //ES5方式
 const logger = function(store){
     return function (next) {
         return function (action) {
             let ret = next(action);
             console.log(store.getState());
             return ret;
         }
     }
 }
 */


 /**
  * 
  * 模拟redux-thunk中间件
  */
 const thunk = store => next => action => {
     return  typeof action == 'function' ? action(store.dispatch, store.getState())  : next(action);
 }


 /**
  * 模拟中间件的引入 
  * @param {*} store 
  * @param {*} midddlewares 
  */
 function applyMiddleware(store, midddlewares){
     midddlewares.slice().reverse();
     let dispatch = store.dispatch;

     midddlewares.forEach(middleware => {
         dispatch = middleware(store)(dispatch);
     });

     Object.assign({},store, {dispatch});
 }

 applyMiddleware(store, [logger, thunk]);

 ```