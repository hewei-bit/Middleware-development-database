@[TOC](C++后端开发（4.5.2）——Nginx过滤器模块实现)

---
` 小节提纲`
>NginxFilter模块运行原理
    过滤链表的顺序
    模块开发数据构ngx_str_t，ngx_list_t，ngx_buf_t，ngx_chain_t
    error日志的用法
    ngx_comondt的讲解
    ngx_http_modul_t的执行流程
    文件锁，互斥锁
    slab共享内存
    如何解决"惊群"问题
    如何实现负载均衡