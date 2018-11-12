## react >= 16.7.alpha.0  Hooks

## 示例-1 (useState, useReducer, useRef, useEffect)

```js
import React, {useState, useEffect, useRef, useReducer} from 'react';


// 类似于redux 的 reducer 用于管理比较复杂的内部状态
function reducer (state = [], action) {
  switch (action.type) {
    case 'add':
      return [...state, {name: 'lisi', age: 10}];
    case 'del':
      state.pop() ;
      return state;
    default: 
      return state;
  }
}


export default function Hook(props) {
  const [count, setCount] = useState(0);

  //状态较多且比较复杂时 ，推荐使用 useReducer
  const [users, dispatch] = useReducer(reducer, []);

  // 更加方便的 ref 获取dom
  const inc = useRef();
  const dec = useRef();

  const increment = () => {
    //状态的修改是直接覆盖，不会进行浅合并
    setCount(count + 1);
  };

  const decrement = () => {
    setCount(count - 1);
  };


  // componentDidUpdate  compoentDidMount  componentWillUnMount执行
  // 执行是异步的
  useEffect(() => {
    console.log('document.title', document.title);
    console.log(inc.current, dec.current);
  });

  // 等价于 useEffect  但是 同步执行
  useLayoutEffect(() => {
    inc.current.click();
  });
  
  return (
    <div>
      <h1>count: {count}</h1>
      <button ref={inc} onClick={increment}>增加</button>
      <button ref={dec} onClick={decrement}>减小</button>


      // 通过dispatch 更新状态
      <button onClick={() => dispatch({type: 'add'})}>添加</button>
      <button onClick={() => dispatch({type: 'del'})}>移除</button>

      <ul>
        {
          users.map((item, index) => {
            return (
              <li key={index}>{item.name}</li>
            )
          })
        }
      </ul>
    </div>
  )
}
```



## 示例-2(useContext)

```js
import React, {useState, useContext} from 'react';
import './Hook2.css';


// 创建Context
const TestContext = React.createContext({
  background: 'green'
});


function InnerComponent(props) {
  // 将context添加到当前组件中,并且 最近的祖先的Provider值发生变化时，会重新渲染
  const context = useContext(TestContext);

  return (
    <div style={{background: context.background}}>
      <h1>useContext测试</h1>
    </div>
  )
}


export default function Hook2(props) {
  const [color, setColor] = useState('green');

  const changeColor = () => {
    if (color === 'green') {
      setColor('yellow');
    } else {
      setColor('green');
    }
  };

  return (
    <div className="hook2">

      // context 的Provider值发生变化时, InnerComponent要重新渲染
      <TestContext.Provider value={{background: color}}>
        <button onClick={() => changeColor()}>改变背景色</button>
        <InnerComponent/>
      </TestContext.Provider>
    </div>
  )
}

```