# CSS特性


## calc计算, var 
calc() 支持简单的 加减乘除.
var 获取css变量值, 定义时需要遵照命名规范

```css
        html:root {
            /*定义变量*/
            --background-color: #fafafa;
        }

        .container {
            width: 500px;
            height: 500px;
            border: 1px solid red;
        }

        .container .item {
            width: calc(100% / 2 );
            height: calc(100% / 2 );
            border: 1px solid green;

            /* 使用var 获取值 */
            background-color: var(--background-color); 
        }
```