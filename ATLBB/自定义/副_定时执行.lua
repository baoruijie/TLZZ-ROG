--[[
    
什么是主脚本
    顺序列表、定时列表通过点击"启动脚本"，"同时启动"执行的是主脚本

什么是副脚本
    打勾"副脚本"选项执行的是副脚本本

副脚本作用(以下只是部分)
    可以与主脚本同时运行
    比如可以实现间隔多长时间自动清包销毁
    比如可以实现类似珍兽奶瓶、一直监测峨嵋加血等功能
    比如可以实现自动组队等
    高级用法
    可以实现执行本机任意玩家正在执行的脚本
    可以定时让主脚本运行什么任务
    可以控制主脚本运行什么脚本,什么时候停止运行

如何自已创建一个副脚本
    在自定义目录新建一个文件名以 "副_" 开始的lua文件即可
    为避免被更新覆盖,如需修改请您另建一个文件

]]
PushColorMsg("副脚本：定时执行任务,相关代码在自定义目录")
-- startHour  必须,开始时间：时
-- startMin   必须,开始时间：分
-- stopHour   可不设置,结束时间：时
-- stopMin    可不设置,结束时间：分
-- scriptName 必须,要执行的任务
local TimeTable = {
    {startHour = 23, startMin = 57, stopHour = 0, stopMin = 1, scriptName = "抢神秘商人"},
    {startHour = 0, startMin = 2, scriptName = "一千零一个愿望"},
    {startHour = 0, startMin = 30, scriptName = "刷怪"}
    -- 这里只是展示,您可以继续添加这个定时任务表,每行要以英文逗号结束
}

while true do
    -- 获取当前时间
    local nowH = tonumber(os.date("%H"))
    local nowM = tonumber(os.date("%M"))

    -- 判断脚本结束
    for i = 1, #TimeTable do
        local tmp = TimeTable[i]
        -- 如果有结束时间且结束时间当前时间和相同
        if tmp.stopHour and tmp.stopMin and tmp.stopHour == nowH and tmp.stopMin == nowM then
            -- 获取主脚本当前运行什么
            GetConfig()
            if g_runing_script == tmp.scriptName then
                -- 停止脚本运行
                PushColorMsg("副脚本：停止定时任务" .. tmp.scriptName)
                MainStopRun(0)
            end
        end
    end

    -- 判断脚本开始
    for i = 1, #TimeTable do
        local tmp = TimeTable[i]
        -- 如果当前时间和相同
        if tmp.startHour == nowH and tmp.startMin == nowM then
            -- 获取主脚本当前运行什么
            GetConfig()
            if g_runing_script ~= tmp.scriptName then
                PushColorMsg("副脚本：执行定时任务" .. tmp.scriptName)
                MainRunScript(tmp.scriptName) -- 让我的主脚本执行此定时任务
            end
            break
        end
    end

    -- 10秒检查一次
    Sleep(10 * 1000)
end
