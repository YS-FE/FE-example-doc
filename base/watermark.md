# 水印

## canvas 绘制

```js

    //canvas 绘制水印
    const canvas = document.createElement('canvas');
    canvas.setAttribute('width', 100);
    canvas.setAttribute('height', 100);
    canvas.setAttribute('opacity', 0.5);
    const ctx = canvas.getContext('2d');

    ctx.fillStyle = "red";
    ctx.rotate(Math.PI / 180 * 20);
    ctx.fillText("OH MY COG", 80, 10);

    //导出url
    var base64Url = canvas.toDataURL();

    //应用到元素
    const watermarkDiv = document.createElement('div');
    watermarkDiv.setAttribute('style',
        `
        position:absolute;
        top:0;
        left:0;
        width:100%;
        height: 100%;
        z-index:1000;
        pointer-events:none;
        background-repeat:repeat;
        background-image:url('${base64Url}')
        `
    );

    //添加到页面即可
    document.body.appendChild(watermarkDiv)
```