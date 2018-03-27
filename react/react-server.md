## react 服务端渲染

## 注意事项
* 安装 ES6编译, react语法支持, 配置.bablerc文件
* renderToString进行页面渲染,并将编译的 js文件载入


## 代码示例

```js

import React  from 'react';
import {renderToString} from 'react-dom/server';

import App from '../containers/App.js';

var router = express.Router();

function renderFullPage(html){
  return `
  <!Doctype html>
  <html>
    <head>
      <title>React-server Universal Example</title>
      <link ref=""shortcut icon" hre
      f="/favicon.ico" type="image/x-icon">
    </head>
    <body>
      <div id="root">${html}</div>
      <script src="/javascripts/main.7761d8e0.js"></script>
    </body>
  </html>
  `
}

router.get('/', function(req, res, next) {

   let html = renderToString(<App/>);
   res.send(renderFullPage(html));
});

module.exports = router;
```