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

        //光标到末尾
        // range.setStart(range.startContainer, textEle.length);
        // range.setEnd(range.endContainer, textEle.length); 
    }

    var img = new Image();
    img.src = "dist/img/ding@3x.png";

    // this.currentRange.insertNode(document.createTextNode("^_^"));
    currentRange.insertNode(img);
```



## 获得光标位置

```js
    //获取富文本框中，光标的字符位置
    // elem 为 富文本编辑器本身
    getCurrentCursorPos (elem) {
        let sel = window.getSelection();
        if (sel.rangeCount > 0) {//选中的区域
            let range = window.getSelection().getRangeAt(0);
            let preCaretRange = range.cloneRange();//克隆一个选中区域
            preCaretRange.selectNodeContents(elem);//设置选中区域的节点内容为当前节点
            preCaretRange.setEnd(range.endContainer, range.endOffset);  //重置选中区域的结束位置
            return preCaretRange.toString().length;
        }
    }
```
