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


```js
    //input textarea  输入框
    getCurrentCursorPos (elem) {
        let cursorPos = 0;
        if (document.selection) {//IE
            let selectRange = document.selection.createRange();
            selectRange.moveStart('character', -event.target.value.length);
            cursorPos = selectRange.text.length;
        } else if (event.target.selectionStart || event.target.selectionStart == '0') {
            cursorPos = event.target.selectionStart;
        }
    }
    
```


## 设置光标位置

```js
  //div 富文本
  setCursorPos(editor, pos) {
    range = document.createRange();//创建一个选中区域
    range.selectNodeContents(editor);//选中节点的内容
    if(editor.innerHTML.length > 0) {
      range.setStart(editor.childNodes[0], pos); //设置光标起始为指定位置
    }

    range.collapse(true);       //设置选中区域为一个点
    let selection = window.getSelection();//获取当前选中区域
    selection.removeAllRanges();//移出所有的选中范围
    selection.addRange(range);//添加新建的范围
  }
```


```js

    //input  textarea
    setCursorPos(editor, pos) {
        if(editor.setSelectionRange) {
            // IE Support
            editor.focus();
            editor.setSelectionRange(pos, pos);
        }else if (editor.createTextRange) {
            // Firefox support
            let range = editor.createTextRange();
            range.collapse(true);
            range.moveEnd('character', pos);
            range.moveStart('character', pos);
            range.select();
        }
    }

```
