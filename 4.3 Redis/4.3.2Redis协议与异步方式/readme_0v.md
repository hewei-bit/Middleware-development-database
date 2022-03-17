## 零声教育出品 Mark 老师  QQ : 2548898954

## 目录说明

>   hiredis 拷贝自 redis 源码；
>
>   libevent 来源于 github；
>
>   evnet 是 Mark 老师所写，之前网络编程课程中已经讲过；
>
>   evmain1.c 用于测试 libevent：只使用 libevent 中io检测的功能；
>
>   evmain2.c 用于测试 libevent：既使用了 libevent 中io检测也使用了它的io操作；

## 编译

### 编译 libevent

```shell
./configure
make
# libevent 生成的库文件在 ./libevent/.libs 中
# libevent 的头文件在 ./libevent/include 中
```

### 编译 hiredis

```shell
make
```

### 编译 evmain1.c

```shell
gcc evmain1.c -I./libevent/include -o ev1 -L./libevent/.libs -levent

# 开启服务端
./ev1
# 另起一个控制台
telnet 127.0.0.1 8989
```

### 编译 evmain2.c

```shell
gcc evmain2.c -I./libevent/include -o ev1 -L./libevent/.libs -levent

# 开启服务端
./ev2
# 另起一个控制台
telnet 127.0.0.1 8989
```

### 编译 evnet

```shell
cd evnet
gcc rbtree.c server.c -o server -I./
# 开启服务端
./server
# 另起一个控制台
telnet 127.0.0.1 8989
```

### 编译 evnet 中 redis 驱动

```shell
# redis 异步驱动
cd evnet
gcc async.c rbtree.c -o async -L../hiredis -lhiredis -I./

# redis 同步驱动
cd evnet
gcc sync.c -o sync -L../hiredis -lhiredis -I./
```

## 测试 redis 驱动

```shell
# 启动 redis-server
redis-server redis.conf

# 运行同步驱动
./sync

# 运行异步驱动
./async
```

