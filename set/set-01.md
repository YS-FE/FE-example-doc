# rzsz 配置(mac)


## 步骤

### 1. 安装 `item2` 终端

### 2. 安装 rzsz `brew install  lrzsz`

### 3. 配置 item2 [参考文档](https://github.com/mmastrac/iterm2-zmodem)

1. /usr/local/bin/  中 创建  iterm2-send-zmodem.sh  iterm2-recv-zmodem.sh  2个文件

2. Set up Triggers in iTerm 2 like so: [How to Create a Trigger](https://www.iterm2.com/documentation-triggers.html)
    Regular expression: rz waiting to receive.\*\*B0100
    Action: Run Silent Coprocess
    Parameters: /usr/local/bin/iterm2-send-zmodem.sh
    Instant: checked

    Regular expression: \*\*B00000000000000
    Action: Run Silent Coprocess
    Parameters: /usr/local/bin/iterm2-recv-zmodem.sh
    Instant: checked
