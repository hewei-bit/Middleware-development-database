#include <netinet/in.h>
#include <sys/socket.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <event.h>
#include <time.h>
#include <signal.h>
#include <event2/listener.h>
#include <event2/bufferevent.h>
#include <event2/buffer.h>

void socket_read_callback(struct bufferevent *bev, void *arg)
{
    struct evbuffer *evbuf = bufferevent_get_input(bev);
    char *msg = evbuffer_readln(evbuf, NULL, EVBUFFER_EOL_LF);
    if (!msg) return;
    
    printf("server read the data: %s\n", msg);

    char reply[4096] = {0};
    sprintf(reply, "recvieced msg: %s\n", msg);
    // -WRN: 需要自己释放资源
    free(msg);
    bufferevent_write(bev, reply, strlen(reply));
}

// void stdio_callback(struct bufferevent *bev, void *arg)
// {
//     struct evbuffer *evbuf = bufferevent_get_input(bev);
//     char *msg = evbuffer_readln(evbuf, NULL, EVBUFFER_EOL_LF);
//     if (!msg) return;

//     if (strcmp(msg, "quit") == 0) {
//         printf("safe exit!!!\n");
//         exit(0);
//         return;
//     }
    
//     printf("stdio read the data: %s\n", msg);
// }

void socket_event_callback(struct bufferevent *bev, short events, void *arg)
{
    if (events & BEV_EVENT_EOF) // read = 0
        printf("connection closed\n");
    else if (events & BEV_EVENT_ERROR) // strerro(errno)
        printf("some other error\n");
    else if (events & BEV_EVENT_TIMEOUT) // 
        printf("timeout\n");
    bufferevent_free(bev); // close(fd)
}

void listener_callback(struct evconnlistener *listener, evutil_socket_t fd,
                       struct sockaddr *sock, int socklen, void *arg)
{
    char ip[32] = {0};
    evutil_inet_ntop(AF_INET, sock, ip, sizeof(ip)-1);
    printf("accept a client fd:%d ip:%s\n", fd, ip);
    struct event_base *base = (struct event_base *)arg;
    struct bufferevent *bev = bufferevent_socket_new(base, fd, BEV_OPT_CLOSE_ON_FREE);

    bufferevent_setcb(bev, socket_read_callback, NULL, socket_event_callback, NULL);
    bufferevent_enable(bev, EV_READ | EV_PERSIST);
}

static void
do_timer(int fd, short events, void* arg) {
    struct event * timer = (struct event *)arg;
    time_t now = time(NULL);
    printf("do_timer %s", (char*)ctime(&now));
    event_del(timer);
    // struct timeval tv = {1,0};
    // event_add(timer, &tv);
}

static void
do_sig_int(int fd, short event, void *arg) {
    struct event *si = (struct event*) arg;
    event_del(si);
    printf("do_sig_int SIGINT\n");
}

int main()
{
    struct sockaddr_in sin;
    memset(&sin, 0, sizeof(struct sockaddr_in));
    sin.sin_family = AF_INET;
    sin.sin_port = htons(8989);

    struct event_base *base = event_base_new();
    struct evconnlistener *listener =
        evconnlistener_new_bind(base, listener_callback, base,
                                LEV_OPT_REUSEABLE | LEV_OPT_CLOSE_ON_FREE,
                                10, (struct sockaddr *)&sin,
                                sizeof(struct sockaddr_in));
	printf("listen port : %d\n", 8989);

    // struct bufferevent *ioev = bufferevent_socket_new(base, 0, BEV_OPT_CLOSE_ON_FREE);
    // bufferevent_setcb(ioev, stdio_callback, NULL, NULL, base);
    // bufferevent_enable(ioev, EV_READ | EV_PERSIST);

    struct event evtimer;
    struct timeval tv = {1,0};
    event_set(&evtimer, -1, 0, do_timer, &evtimer);
    event_base_set(base, &evtimer);
    event_add(&evtimer, &tv);

    struct event evint;
    event_set(&evint, SIGINT, EV_SIGNAL, do_sig_int, &evint);
    event_base_set(base, &evint);
    event_add(&evint, NULL);

    event_base_dispatch(base);
    evconnlistener_free(listener);
    event_base_free(base);
    return 0;
}

/*
gcc evmain2.c -I./libevent/include -o ev2 -L./libevent/.libs -levent
client:
    telnet 127.0.0.1 8989
*/
