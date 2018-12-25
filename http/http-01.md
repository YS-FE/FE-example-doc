# http

## accept 头

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
const http = require('http')
const fs = require('fs')
const zlib = require('zlib')

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



## cache-control

```js
//server.js

const http = require('http')
const fs = require('fs')

http.createServer(function (request, response) {

  if (request.url === '/') {
    const html = fs.readFileSync('test.html', 'utf8')
    response.writeHead(200, {
      'Content-Type': 'text/html'
    })
    response.end(html)
  }

  if (request.url === '/script.js') {
    response.writeHead(200, {
      'Content-Type': 'text/javascript',
      'Cache-Control': 'max-age=20' //设置缓存时间
    })
    response.end('console.log("script loaded")')
  }
}).listen(8888)
```


## cookie

```js
//server.js

const http = require('http')
const fs = require('fs')

http.createServer(function (request, response) {
  console.log('request come', request.url)

  if (request.url === '/') {
    const html = fs.readFileSync('test.html', 'utf8')
    response.writeHead(200, {
      'Content-Type': 'text/html',
      'Set-Cookie': ['id=123; max-age=2', 'abc=456;domain=test.com']
    })
    response.end(html)
  }

}).listen(8888)
```



## connection

```js
//server.js

const http = require('http')
const fs = require('fs')

http.createServer(function (request, response) {

  const html = fs.readFileSync('test.html', 'utf8')
  const img = fs.readFileSync('test.jpg')
  if (request.url === '/') {
    response.writeHead(200, {
      'Content-Type': 'text/html',
    })
    response.end(html)
  } else {
    response.writeHead(200, {
      'Content-Type': 'image/jpg',
      'Connection': 'keep-alive' // or close,  浏览器会复用连接或者 重新创建连接
    })
    response.end(img)
  }

}).listen(8888)
```



## cors  跨域设置

### 跨域的 请求方法，请求头，都有限制

```js
const http = require('http')

http.createServer(function (request, response) {
  response.writeHead(200, {
    'Access-Control-Allow-Origin': 'http://127.0.0.1:8888',
    'Access-Control-Allow-Headers': 'X-Test-Cors',
    'Access-Control-Allow-Methods': 'POST, PUT, DELETE',
    'Access-Control-Max-Age': '1000'
  })

  response.end('hello world!');

}).listen(8887)
```




## Content-Security-Policy 内容安全策略


```html

<!-- client -->
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <meta http-equiv="Content-Security-Policy" content="script-src 'self'; form-action 'self';">
  <title>Document</title>
</head>
<body>
  <div>This is content</div>
  <script>
    console.log('inline js')
  </script>
  <script src="test.js"></script>
  <script src="https://cdn.bootcss.com/jquery/3.3.1/core.js"></script>
</body>
</html>
```

```js
//server.js

const http = require('http')
const fs = require('fs')

http.createServer(function (request, response) {

  if (request.url === '/') {
    const html = fs.readFileSync('test.html', 'utf8')
    response.writeHead(200, {
      'Content-Type': 'text/html',
      'Content-Security-Policy': 'script-src \'self\'; form-action \'self\'; report-uri /report'
    })
    response.end(html)
  }
);

```



## redirect 重定向

```js

//server.js

const http = require('http')

http.createServer(function (request, response) {

  if (request.url === '/') {
    response.writeHead(302, {  // or 301
      'Location': '/new'
    })
    response.end()
  }

  if (request.url === '/new') {
    response.writeHead(200, {
      'Content-Type': 'text/html',
    })
    response.end('<div>this is content</div>')
  }
}).listen(8888);

```



## Etag

```js
const http = require('http')
const fs = require('fs')

http.createServer(function (request, response) {

  if (request.url === '/') {
    const html = fs.readFileSync('test.html', 'utf8')
    response.writeHead(200, {
      'Content-Type': 'text/html'
    })
    response.end(html)
  }

  if (request.url === '/script.js') {
    
    const etag = request.headers['if-none-match']

    if (etag === '777') {
      response.writeHead(304, {
        'Content-Type': 'text/javascript',
        'Cache-Control': 'max-age=2000000, no-cache',
        'Last-Modified': '123',
        'Etag': '777'
      })
      response.end();

    } else {
      response.writeHead(200, {
        'Content-Type': 'text/javascript',
        'Cache-Control': 'max-age=2000000, no-cache',
        'Last-Modified': '123',
        'Etag': '777'
      })
      response.end('console.log("script loaded twice")')
    }
  }
}).listen(8888);
```


## Vary
### WEB服务器用该头部的内容告诉 Cache 服务器，在什么条件下才能用本响应所返回的对象响应后续的请求


```html
<!-- client -->

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Document</title>
</head>
<body>
  <div>This is content, and data is: <span id="data"></span></div>
  <button id="button">click me</button>
</body>
<script>
  var index = 0
  function doRequest () {
    var data = document.getElementById('data')
    data.innerText = ''
    fetch('/data', {
      headers: {
        'X-Test-Cache': index++
      }
    }).then(function (resp) {
      return resp.text()
    }).then(function (text) {
      data.innerText = text
    })
  }
  document.getElementById('button').addEventListener('click', doRequest)
</script>
</html>
```

```js

//server.js
const http = require('http')
const fs = require('fs')

const wait = (seconds) => {
  return new Promise((resolve) => {
    setTimeout(resolve, seconds * 1000)
  })
}
http.createServer(function (request, response) {
  console.log('request come', request.url)

  if (request.url === '/') {
    const html = fs.readFileSync('test.html', 'utf8')
    response.writeHead(200, {
      'Content-Type': 'text/html'
    })
    response.end(html)
  }

  if (request.url === '/data') {
    response.writeHead(200, {
      'Cache-Control': 'max-age=2, s-maxage=20, private',
      'Vary': 'X-Test-Cache'
    })
    wait(2).then(() => response.end('success'))
  }
}).listen(8888)
```