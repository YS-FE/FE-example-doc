# 控制光标的位置

## 富文本编辑时，控制字符个数，控制光标位置

```html
    <div id="editor" contenteditable="true"></div>
```
```js
        let node = document.getElementById('editor');

        $("#editor").on('input', function () {
            let temp = $(this).text();

            if (temp.length > 8) {
                $(this).text(temp.slice(0, 8)); //截取字符

                var sel = window.getSelection();
                var range = document.createRange();
                range.selectNodeContents($('#editor').get(0)); //设置选择范围

                // range.setStart(node.childNodes[0], 0); //设置范围
                // range.setEnd(node.childNodes[0], 3);

                range.collapse(false); //参数为true时，文本会处于选中的状态!!!!
                sel.removeAllRanges();
                sel.addRange(range); // 截取之后保证光标仍然在最后
            }
        })

```


## 富文本编辑时，插入图片

```html
  <div id="editor" contenteditable="true"></div>
```

```js
    var selection = window.getSelection();
    var currRange;

    if (selection.rangeCount) {
        currentRange = selection.getRangeAt(0);
    }

    var img = new Image();
    img.src = "dist/img/ding@3x.png";

    // this.currentRange.insertNode(document.createTextNode("^_^"));
    currentRange.insertNode(img);
```
