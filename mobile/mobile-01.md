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


## 2.弹层滚动穿透问题
解决方案：阻止`document`的滚动，只允许需要滚动的元素进行滚动

```js

    let canScrollElems = [];
    document.addEventListener('touchmove', function(event){

        //只允许其中可以滚动的元素进行滚动
        let canScroll = canScrollElems.find(el => {
            return event.target == el ;
        });
        if (canScroll) return;

        event.preventDefault();
    }, {
        passive: false
    });


    let startY = endY = 0;

    //scrollEle 滚动的元素
    scrollEle.addEventListener('touchstart', funtion(event){
        if (event.targetTouches.length == 1) {
            starY = event.targetTouches[0].clientY;
        }
    });

    scrollEle.addEventListener('touchmove', funtion(event){

        if (event.targetTouches.length == 1) {
            endY = event.targetTouches[0].clientY;
            let result = endY - starY;

            // 滚动到底部, 取消默认行为
            if ((this.scrollTop + this.clientHeight >= this.scrollHeight)  &&  (result <= 0)) {
                event.preventDefault();
                return;
            } 

            // 滚动到顶部, 取消默认行为
            if ((this.scrollTop <= 0)  &&  (result >= 0)) {
                event.preventDefault();
                return;
            } 
        }
    });

```



## 3. H5页面，虚拟键盘消失后底部留白问题
虚拟键盘输入完成之后，键盘收起之后，部分机型出现，底部留白问题。    

解决方法: 
1. 在完成输入之后，失去焦点，重新设置页面的位置(`focusout`可冒泡,多输入可以设置代理)
2. 监听 `window.onresize`事件(`android`可以，`ios`不行)

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


```js
var defaultHeight = window.innerHeight;

window.onresize = function() {

    // 考虑到浏览器的导航栏或者底部栏的变化
    if ((window.innerHeight - defaultHeight) > 150) {
        window.scrollTo({
            left: 0,
            top: currentScroll,
            behavior: 'smooth'
        })
    }
}
```



## 4. 阻止 ios 橡皮筋效果
解决方法: 滚到到阈值时，禁止触摸的默认行为即可，但是需要 传递`passive: false`参数

```js


    var startY = 0, endY = 0;

    document.body.addEventListener('touchstart', function (event) {
        startY = event.touches[0].pageY;
    });

    document.body.addEventListener('touchmove', function (event) {
        endY = event.changedTouches[0].pageY;

        // up
        if (startY < endY) {
            let scrollTop = document.body.scrollTop || document.documentElement.scrollTop;
            if (scrollTop <= 0) {
                event.preventDefault();
            }

        } else {
            //down
            let scrollTop = document.body.scrollTop || document.documentElement.scrollTop;
            let scrollHeight = document.body.scrollHeight || document.documentElement.scrollHeight;

            if ((scrollTop + window.innerHeight) >= scrollHeight) {
                event.preventDefault();
            }
        }
    }, {
        passive: false
    });

```


## 5. video的局部播放
ios、android 播放video视频时，行为不一致，ios会打开新的窗口进行播放。     
使用 `video`的标签属性 `playsinline` 进行限制即可

```html
    <video id="videoOne" controls 
    webkit-playsinline="true" playsinline="true"  
    poster="./dist/img/xiangqing.png"  src="./dist/img/video.mp4"></video>
```