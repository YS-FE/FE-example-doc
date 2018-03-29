# 移动端浏览器调试


## m-console工具
移动浏览器的语法支持情况不同,通过window.onerror和 m-console将出错具体信息输出到pc上方便定位错误。

### 操作
* 安装 `npm i m-console -g`
* 运行 m-console服务 `mcon server`
* 将输出的 `<script type="text/javascript" src="http://xx.yy.zz.aa:3000/m-console.js"></script>`添加到html
* HTML 代码中 注册 window.onerror错误捕获
* 手机需要通过代理连接PC,并在PC上打开页面,调试信息会输出到PC的控制台
* 代理可以使用charles等工具

#### 如下
```js
    <script>
        window.onerror = function (message, source, lineno, colno, error) {
            console.log("%c----------error----------", "color:red;font-size:30px");
            console.log(message);
            console.log(source);
            console.log(lineno);
            console.log(colno);
            console.log(error);
            console.log("%c----------error----------", "color:red;font-size:30px");
        }
    </script>
    <script type="text/javascript" src="http://10.252.54.118:3000/m-console.js"></script>
```


## v-console工具
v-console工具方便将调试信息直接在手机上输出(log,storage,network等),但是有语法错误或者不支持信誉发时时就无效了。

### 操作
* 安装 `npm i vconsole`
* HTML 代码中引入 vconsole.min.js
* new VConsole()
* 手机浏览器打开页面即可查看

#### 如下

```js
   <script src="./vconsole.min.js"></script>
    <script>
        new VConsole();
        console.log('test');
        console.error("error");
    </script>
```

## <span style="color:red;">根据不同需求选择不同的工具即可</span>



