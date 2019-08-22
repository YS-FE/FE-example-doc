#片段

1. download 
```js
const http = require('http');
const fs = require('fs');

let data = '';
let req = http.request("http://127.0.0.1:3000/12.zip", {
    method: 'GET'
}, res => {
    res.setEncoding('binary');
    res.on('data', chunk => {
        data += chunk;
    });

    res.on('end', () => {
        fs.writeFileSync('xxx.zip', data, "binary");
    });
});

req.on('error', (err) => {
    console.log(err);
});

req.end();
```js
