# react-router-4.x 

## react-router 中使用 javascript控制路由跳转
* 使用 withRouter 高阶组件
* 使用 history库
* context 上下文


### 使用 withRouter 高阶组件

使用 BrowserRouter 方式时,使用 withRouter对组件进行包裹，history 会挂载在props上

```js
import React from "react";
import { withRouter } from 'react-router';
import { BrowserRouter as Router, Route, Link } from "react-router-dom";

class Com  extends React.Component {
  ...
  routerCtrl() {
    this.props.history.push("/xxx/yyy");
  }
  ...
}
export default withRouter(Com);

```


### 使用 history库
使用 Router时, 手动指定 history

```js

//project-history.js 创建history
import createHistory from 'history/createBrowserHistory';
export default createHistory();

//路由添加
import history from './project-history.js';
import {Router, Route, Link } from "react-router-dom";

<Router history={history}>
...
</Router>


//组件内部引入指定的history, 然后直接进行操作即可
import history from './project-history.js';
class Com  extends React.Component {
  ...
  routerCtrl() {
    history.push("/xxx/yyy");
  }
  ...
}


```


### context 上下文
react-router v4 通过Contex暴露了一个router对象给所有组件

```js
import PropTypes from 'prop-types'
class Com  extends React.Component {

  static contextTypes = {
      router:  PropTypes.Object
  }
  ...
  routerCtrl() {
    //直接从上下文上进行访问即可
    this.context.router.history.push("/xxx/yyy");
  }
  ...
}
```




