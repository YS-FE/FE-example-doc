## bull 消息队列 for nodejs
基于redis，redis-server需启动

## demo

```js
// server A
const Queue = require('bull');
let queueA = new Queue("test-one");

setInterval(() => {
    queueA.add('job1', {msg: 'namedjob_' + Date.now()});
    queueA.add({msg: 'helloworld_' + Date.now()});
}, 1000);

```


```js
// server B

const Queue = require('bull');
let queueA = new Queue("test-one");

queueA.process((job, Done) => {
    console.log("current job =  ", JSON.stringify(job));
    Done(null, 'ok');
});


queueA.process('job1', (job, Done) => {
    console.log("job1 =  ", JSON.stringify(job));
    Done(null, 'ok');
});


queueA.on('completed', (job, result) => {
    console.log('complete job = ', JSON.stringify(job));
});

```