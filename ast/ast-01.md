# 基于babel的ast操作

## 文档
[babel文档](https://babeljs.io/docs)


## 核心模块

1. `@babel/core`      核心模块
2. `@babel/types`     ast 类型模块
3. `@babel/traverse`  ast 遍历
4. `@babel/generator` ast生成code
5. `@babel/template`  生成ast


## demo

```js
const babel = require('@babel/core');
const types = require('@babel/types');
const traverse = require('@babel/traverse');
const gen = require('@babel/generator');
const template = require('@babel/template').default;


let code1 = `
let fn = (a, b) => {
  
  	let result = a + b;
    this.hello = 'world';
    console.log(result);
}
`;

let code2 = `let fn = function (a, b) {
    return a + b;
}`;



//visitor
let updateParamNameVisitor = {
    Identifier: function (path, state) {
        if (path.node.name === this.orgParamName1) {
            path.node.name = 'aa';
        }

        if (path.node.name === this.orgParamName2) {
            path.node.name = 'bb';
        }
    }
};


//visitor
let updateExpressionVisitor = {
    BinaryExpression: function(path, state) {
        if (this.needTrans && (path.node.operator === '+')) {
            path.node.left = types.identifier('aa');
            path.node.right = types.identifier('bb');
        }
     }
};


// babel.transform插件
let arrPlugin = {
    visitor: {
        ArrowFunctionExpression: function(path, state) {
            // console.log(path.node);
            // console.log('params -->', path.node.params);

            let param1 = path.node.params[0];
            let param2 = path.node.params[1];
            let orgParamName1 = param1.name;
            let orgParamName2 = param2.name;

            param1.name = 'aa';
            param2.name = 'bb';


            //从某个类型判断中 调用另外的visitor
            path.traverse(updateParamNameVisitor, {paramName1: orgParamName1,  paramName2: orgParamName2});
            path.traverse(updateExpressionVisitor, {needTrans: true});


            //使用 @babel/template 添加节点，要方便很多
            // let buildRequire = template(`
            //     var IMPORT_NAME = VALUE;
            // `);

            // let ast = buildRequire({
            //     IMPORT_NAME: types.identifier('result'),
            //     VALUE: types.NumericLiteral(10)
            // });

            
            let ast = template.ast(`
                var test = 10;
            `);
            
            //添加 ast
            path.get("body").unshiftContainer("body",  ast);

            //箭头函数转换
            path.arrowFunctionToShadowed();
        }
    }
}

let result = babel.transformSync(code1, {
    ast: true,
    plugins: [arrPlugin]
});


// console.log(JSON.stringify(result.ast, null, '\t'));
console.log(result.code);

```