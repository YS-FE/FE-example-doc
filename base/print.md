# 浏览器打印




##  vue-print-nb



## jquery.print.js   

```js

  jQuery(id).print({
      noPrintSelector: ".no-print",
      timeout: 750,
  });
```


## 原生js

```js
      print () {
        let frame = this.appendFrame();

        // Safari
        if (!window.onafterprint) {
          // emulate onbeforeprint/onafterprint events
          var mediaQueryCallback = function (mql) {
            if (!mql.matches && frame) {
              document.body.removeChild(frame);
            }
          };


          let mediaQueryList = window.frames[frame.name].matchMedia('print');
          mediaQueryList.addListener(mediaQueryCallback);

          // the code below will trigger a cleanup in case a user hits Cancel button
          // in that Safari's new additional print confirmation dialog
          window.frames[frame.name].focus();
          window.frames[frame.name].onfocus = function () {
            return mediaQueryCallback(mediaQueryList);
          };
        }

        frame.onload = () => {
          window.frames[frame.name].print();
        }

        return false;
      },

      appendFrame() {
        let contents = document.getElementById(this.$refs.printEle.id).outerHTML;
        let str = '';

        let links = document.head.querySelectorAll('link');
        Array.from(links).forEach(item => {
          str += item.outerHTML;
        });

        let styles = document.head.querySelectorAll('style');
        Array.from(styles).forEach(item => {
          str += item.outerHTML;
        });


        let frame1 = document.createElement('iframe');
        frame1.name = "frame3";
        frame1.style.position = "absolute";
        frame1.style.top = "-1000000px";
        document.body.appendChild(frame1);

        let frameDoc = frame1.contentWindow ? frame1.contentWindow : frame1.contentDocument.document ? frame1.contentDocument.document : frame1.contentDocument;
        frameDoc.document.open();
        frameDoc.document.write(`<html><head><title>人社部大学</title>${str}</head>`);
        frameDoc.document.write('<body>');
        frameDoc.document.write(contents);
        frameDoc.document.write('</body></html>');
        frameDoc.document.close();

        return frame1;
      },

```