# video

## video 视频流, 拍照并处理图片

```html

<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <title>获得视频流，拍照</title>
  <style media="screen">
  #show img {
    width: 180px;
    height: 90px;
    border-radius: 4px;
    margin-left: 5px;
  }

  .operation {
    padding: 20px;
  }
  .operation button {
    border: none;
    outline: none;
    border-radius: 4px;
    color: #fff;
    background: #409EFF;
    border-color: 409EFF;
  }
  </style>
</head>

<body>

  <video id="video" autoplay style="width:480px;height:320px;"></video>
  <canvas id="canvas" style="display:none;"></canvas>

 <div class="operation">
  <button type="button" onclick="capture(event)">开始捕获</button>
 </div>

 <div id="show"></div>

  <script type="text/javascript">

    var video = document.querySelector('#video');
    var show = document.querySelector('#show')
    var canvas = document.querySelector('#canvas');
    canvas.width = 480;
    canvas.height = 320;
    var cxt = canvas.getContext('2d');

    
    //开启视频设备
    function testVideo(){
        var p = navigator.mediaDevices.getUserMedia({
        audio: true,
        video: { width: 1280, height: 720 }
        });

        p.then(function(mediaStream) {
        // video.src = window.URL.createObjectURL(mediaStream);
        video.srcObject = mediaStream;
        video.onloadedmetadata = function(e) {
            console.log(video.duration);
        };
        });

        p.catch(function(err) {
        console.log(err.name);
        });
    }


    // 拍照
    function capture(event){
        //绘制图片
        cxt.drawImage(video,0,0,480,320);

        /// 转为黑白
        let length = canvas.width * canvas.height;
        imageData = cxt.getImageData(0, 0, canvas.width, canvas.height);
        for (let i = 0; i < length * 4; i += 4) {
            let myRed = imageData.data[i];
            let myGreen = imageData.data[i + 1];
            let myBlue = imageData.data[i + 2];
            myGray = parseInt((myRed + myGreen + myBlue) / 3);
            imageData.data[i] = myGray;
            imageData.data[i + 1] = myGray;
            imageData.data[i + 2] = myGray;
        }

        cxt.putImageData(imageData, 0, 0);
        

        //输出图片
        let src = canvas.toDataURL('image/jpeg', 1.0);
        let img  = document.createElement('img');
        img.src = src;
        show.appendChild(img);
    }


   testVideo();
  </script>
</body>

</html>

```


## video 内联播放

### video  添加 webkit-playsinline、 playsinline

```html
    <video id="videoOne" controls webkit-playsinline="true" playsinline="true"  
    poster="./dist/img/xiangqing.png"  src="./dist/img/video.mp4"></video>
```