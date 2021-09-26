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
PushColorMsg("副脚本：监控执行队长的任务,相关代码在自定义目录")
while true do
    local leader, isleader = Team:GetLeaderInfo() -- 获取队长信息
    if leader and not isleader then -- 得到队长信息且自己不是队长
        local leaderScript = GetLocalPlayerScript(leader.name) -- 用队长的名称从主控获取执行的任务

        -- 获取我自己正在执行的脚本,保存在 g_runing_script
        GetConfig()

        if leaderScript == "" then
            -- 队长没有执行什么任务、或者主控还没有刷新队长的任务
            if g_runing_script ~= "" then
                PushColorMsg("队长没有执行任务,停止执行")
                MainStopRun(1) -- 让我主脚本停止运行,1表示停止后也不执行列表任务
            end
        else
            -- 我运行的脚本和队长不一样
            if g_runing_script ~= leaderScript then
                -- 获取我的地图ID
                local selfScene = GetSceneID()

                -- 是否可以执行队长的任务
                local bCanDo = true

                if IsInFubenScene(leader.sceneID) and leader.sceneID ~= 280 then -- 排除凤凰古城
                    if leader.sceneID ~= selfScene then
                        DebugStr("队长在副本地图,暂不执行队长任务")
                        bCanDo = false -- 队长在副本地图,我却不在副本地图，不执行队长任务
                    end
                end

                if IsInFubenScene(selfScene) then
                    if leader.sceneID ~= selfScene then
                        DebugStr("我在副本地图,暂不执行队长任务")
                        bCanDo = false -- 我在副本地图,队长不在副本地图，不执行队长任务
                    end
                end
                if bCanDo then
                    PushColorMsg("队长正在运行：" .. leaderScript .. " 与我运行的不一致：" .. g_runing_script)
                    MainRunScript(leaderScript) -- 让我的主脚本执行队长的任务
                end
            end
        end
    end
    Sleep(3000)
end
