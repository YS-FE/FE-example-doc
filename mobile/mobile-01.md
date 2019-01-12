# Mobile 问题汇总


## 1.弹层滚动穿透问题
解决方法： 弹出弹层时，将body设置为 `position:fixed`,并记录滚动位置

<span style="color:red;">注意:</span> 移动端 直接设置 body `height: 100%; overflow:hidden;`是没作用的

```css
body.has-mask {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    overflow: hidden;
}
```

```js

    var lastScrollPos = 0;

    //body停止滚动,并记录当前滚动位置
    function stopScroll() {
        lastScrollPos = document.body.scrollTop || document.documentElement.scrollTop;
        document.body.classList.add('has-mask');
        document.body.style.top = -lastScrollPos + 'px';
    },

    // 回复body的滚动，并返回之前的滚动位置
    function backScroll() {
        document.body.classList.remove('has-mask');
        window.scrollTo(0, lastScrollPos);
    }
```



## 2. H5页面，虚拟键盘消失后底部留白问题
虚拟键盘输入完成之后，键盘收起之后，部分机型出现，底部留白问题。
解决方法: 在完成输入之后，失去焦点，重新设置页面的位置

```js

var currentScroll = 0;

//获得焦点时，记录位置
function getFocus(event) {
    currentScroll = document.body.scrollTop || document.documentElement.scrollTop;
}

//输入完成，失去焦点之后，更新滚动位置即可
function afterBlur(event){
    window.scrollTo({
        left: 0,
        top: currentScroll,
        behavior: 'smooth'
    })
}

```
