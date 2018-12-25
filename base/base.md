# base


## visibilitychange  页面显示或隐藏时触发

```js

document.addEventListener("visibilitychange", function() {
  console.log( document.visibilityState ); //visible, hidden
});

```



## 检测浏览器FPS

```js

    var lastTime = performance.now();
    var lastFameTime = performance.now();
    var frame = 0;

    var loop = function (time) {
      var now = performance.now();
      var fs = (now - lastFameTime);
      lastFameTime = now;
      var fps = Math.round(1000 / fs);
      frame++;


      //fps 越接近60, 越流畅
      console.log(fps);

      if (now > 1000 + lastTime) {
        var fps = Math.round((frame * 1000) / (now - lastTime));
        frame = 0;
        lastTime = now;
      };
      window.requestAnimationFrame(loop);
    };

```



## MutationObserver 检测 dom的变化

```html
<body>

  <div id="test01">测试</div>
  <div id="test02">测试02</div>

  <button id="btn">点击</button>

  <script>

    var button = document.getElementById("btn");
    var targetNode01 = document.getElementById('test01');
    var targetNode02 = document.getElementById('test02');

    button.addEventListener('click', function(event){
      targetNode01.classList.add('class01');
      targetNode02.innerHTML =  "测试测试测试0000";
    });


    // Options for the observer (which mutations to observe)
    var config = {
      attributes: true,
      childList: true,
      subtree: true
    };

    // Callback function to execute when mutations are observed
    var callback = function (mutationsList) {

      console.log(mutationsList);
      
      for (var mutation of mutationsList) {
        if (mutation.type == 'childList') {
          console.log('A child node has been added or removed.');
        } else if (mutation.type == 'attributes') {
          console.log('The ' + mutation.attributeName + ' attribute was modified.');
        }
      }
    };

    // Create an observer instance linked to the callback function
    var observer = new MutationObserver(callback);

    // Start observing the target node for configured mutations
    observer.observe(targetNode01, config);
    
    observer.observe(targetNode02, config);

  </script>
</body>
```