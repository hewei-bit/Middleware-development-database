cmake_minimum_required(VERSION 3.0)

project(redis_async_HW)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")

set(CMAKE_BUILD_TYPE Debug)

include_directories(${CMAKE_SOURCE_DIR}/hiredis)
include_directories(${CMAKE_SOURCE_DIR}/hiredis/adapters)
include_directories(${CMAKE_SOURCE_DIR}/libevent/include)
include_directories(${CMAKE_SOURCE_DIR}/libevent/include/event2)
include_directories(${CMAKE_SOURCE_DIR}/${evnet_src})

# 并将名称保存到 DIR_LIB_SRCS 变量
AUX_SOURCE_DIRECTORY(./hiredis DIR_LIB_SRCS)
# 生成静态库链接库Dir1
ADD_LIBRARY (hiredis ${DIR_LIB_SRCS})

set(evnet_src "src/example/evnet")
add_executable(sync ${evnet_src}/sync.c) 
TARGET_LINK_LIBRARIES(sync hiredis)

add_executable(async ${evnet_src}/async.c ${evnet_src}/rbtree.c)
TARGET_LINK_LIBRARIES(async hiredis)

add_executable(server ${evnet_src}/server.c ${evnet_src}/rbtree.c)

add_executable(ev1 ./src/example/evmain1.c)
TARGET_LINK_LIBRARIES(ev1 event)

add_executable(ev2 ./src/example/evmain1.c)
TARGET_LINK_LIBRARIES(ev2 event)
