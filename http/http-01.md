# http

## accept

```html
  <!-- client -->
  <form action="/form" id="form" enctype="application/x-www-form-urlencoded">
    <input type="text" name="name">
    <input type="password" name="password">
    <input type="file" name="file">
    <input type="submit">
  </form>
  <script>
    var form = document.getElementById('form')
    form.addEventListener('submit', function (e) {
      e.preventDefault()
      var formData = new FormData(form)
      fetch('/form', {
        method: 'POST',
        body: formData
      })
    })
  </script>
```

```js
//server.js
http.createServer(function (request, response) {
  const html = fs.readFileSync('test.html')

  response.writeHead(200, {
    'Content-Type': 'text/html',
    // 'X-Content-Options': 'nosniff'
    'Content-Encoding': 'gzip'
  })

  response.end(zlib.gzipSync(html));

}).listen(8888);

```