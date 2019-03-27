## picture-in-picture
[w3c 相关文档](https://wicg.github.io/picture-in-picture/)   

```html
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Document</title>
</head>

<body>

  <video id="video" width="400" src="./video.mp4"></video>

  <button id="togglePipButton">toggle</button>

  <script>
    const video = document.getElementById('video');
    const togglePipButton = document.getElementById('togglePipButton');

    // Hide button if Picture-in-Picture is not supported or disabled.
    togglePipButton.hidden = !document.pictureInPictureEnabled ||
      video.disablePictureInPicture;

    togglePipButton.addEventListener('click', function () {
      // If there is no element in Picture-in-Picture yet, let’s request
      // Picture-in-Picture for the video, otherwise leave it.
      if (!document.pictureInPictureElement) {
        video.requestPictureInPicture()
          .catch(error => {
            // Video failed to enter Picture-in-Picture mode.
          });
      } else {
        document.exitPictureInPicture()
          .catch(error => {
            // Video failed to leave Picture-in-Picture mode.
          });
      }
    });

  </script>
</body>
</html>
```
