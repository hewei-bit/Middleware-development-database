local ops = require("redisOps") --加载redis操作模块

local row = ops.rawRow()  --当前数据库的一行数据,table类型，key为列名称
local action = ops.rawAction()  --当前数据库事件,包括：insert、update、delete

if action == "insert" or action == "update" then -- 只监听insert事件
    local id = row["id"] --获取ID列的值
    local key = "user:" .. id
    local name = row["nick"] --获取USER_NAME列的值
    local sex = row["sex"]
    local height = row["height"] --获取PASSWORD列的值
    local age = row["age"]
    ops.HSET(key, "id", id) -- 对应Redis的HSET命令
    ops.HSET(key, "nick", name) -- 对应Redis的HSET命令
    ops.HSET(key, "sex", sex) -- 对应Redis的HSET命令
    ops.HSET(key, "height", height) -- 对应Redis的HSET命令
    ops.HSET(key, "age", age) -- 对应Redis的HSET命令
elseif action == "delete" then
    local id = row['id']
    local key = "user:" .. id
    ops.DEL(key)
end