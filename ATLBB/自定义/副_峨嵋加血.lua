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
PushColorMsg("副脚本：峨嵋实时加血,相关代码在自定义目录")

-- 获取配置,获取一次用户设置的加血对象后,就不再重复获取了
GetConfig()

-- 获取自己的门派名字等保存在 g_self 表
PlayerDataInit()

-- 将获取到的配置解析到CDG
CommonParamInit("")

-- 如需定制加血对象,可解除屏蔽/编辑下面的代码
-- CDG.hp.em_firstlist_name = "" -- 优先加血列表取消
-- CDG.hp.em_bh_self = false -- 帮会加血取消
-- CDG.hp.em_tm_self = false -- 同盟加血取消
-- CDG.hp.em_bh_id = "" -- 帮会ID加血取消
-- CDG.hp.em_namelist = "" -- 名字列表加血取消
-- CDG.hp.em_raid = false -- 团队加血取消
-- CDG.hp.em_team = false -- 队伍加血取消

while true do
    -- 确认峨嵋派4
    if g_self.menpai == 4 then
        local nState = Player:GetState()
        -- 确认当前无动作的情况
        if nState == 0 then
            -- 确认当前没有坐骑
            if not IsMount() then
                -- not IsGuanShanHaiScene() 不在观山海地图,因为观山海慕容复加血会恢复自己的血量
                -- 确认不在副本地图
                if not IsInFubenScene() then
                    -- 确认状态能加血,不是传送保护
                    if Player:GetBuff("无敌") == -1 and Player:GetBuff("神佑") == -1 then
                        local add_hp_name = CDG:checkHP_Player() -- 加血
                        if add_hp_name == "" then
                            CDG:checkHP(false) -- 没找到加血对象再次检查给自己加血
                        end
                        -- 回蓝
                        CDG:checkMP(true)
                    end
                end
            end
        end
    end
    Sleep(500)
end
