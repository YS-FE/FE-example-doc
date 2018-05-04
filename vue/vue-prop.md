# prop '双向绑定'


## 方法一

```js

1. 父组件中

//给子组件 text-document传递 title属性
<text-document
  v-bind:title="doc.title"
  v-on:update:title="doc.title = $event"
></text-document>

data() {
    return {
        doc: {
            title: {},
            ...
        }
    }
}


2. 子组件中
this.$emit("update:title", title);

```

## 方法二

使用vue sync关键字

```js


1. 父组件中

//给子组件 text-document传递 title属性
<text-document
  v-bind:title.sync="doc.title"
></text-document>

data() {
    return {
        doc: {
            title: {},
            ...
        }
    }
}

2. 子组件中
this.$emit("update:title", title);

```


## 示例代码

```
父组件
<child-one v-bind:one.sync="doc.one"></child-one>
<child-two v-bind:two.sync="doc.two"></child-two>

data(){
    return {
        doc: {
            one: {},
            two: {},
            ...
        }
    }
}

```



```
子组件 child-one

<div>
 <input v-mode="childOne.text"/>
<div>

created(){
}

mounted(){
    /*
    当子组件对象结构和父组件传递的完全一致时,可以直接将事件触发的代码放在mounted中
    如果结构不一致时，那么就需要在iput触发的自定事件中 去触发emit了
    */
    this.$emit("update:one", this.childOne);
}

watch: {
    one: function(newValue, oldValue){
        //当prop改变时，赋值给子组件的data
        this.childOne = newValue;
    }
}

data(){
    return {
        childOne: {
            text: ''
        }
    }
}

props: {
    one: {
        type: Object,
        required: true
    }
}

```

