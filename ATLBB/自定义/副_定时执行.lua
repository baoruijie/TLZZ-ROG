--[[
    
ʲô�����ű�
    ˳���б���ʱ�б�ͨ�����"�����ű�"��"ͬʱ����"ִ�е������ű�

ʲô�Ǹ��ű�
    ��"���ű�"ѡ��ִ�е��Ǹ��ű���

���ű�����(����ֻ�ǲ���)
    ���������ű�ͬʱ����
    �������ʵ�ּ���೤ʱ���Զ��������
    �������ʵ������������ƿ��һֱ�����Ҽ�Ѫ�ȹ���
    �������ʵ���Զ���ӵ�
    �߼��÷�
    ����ʵ��ִ�б��������������ִ�еĽű�
    ���Զ�ʱ�����ű�����ʲô����
    ���Կ������ű�����ʲô�ű�,ʲôʱ��ֹͣ����

������Ѵ���һ�����ű�
    ���Զ���Ŀ¼�½�һ���ļ����� "��_" ��ʼ��lua�ļ�����
    Ϊ���ⱻ���¸���,�����޸�������һ���ļ�

]]
PushColorMsg("���ű�����ʱִ������,��ش������Զ���Ŀ¼")
-- startHour  ����,��ʼʱ�䣺ʱ
-- startMin   ����,��ʼʱ�䣺��
-- stopHour   �ɲ�����,����ʱ�䣺ʱ
-- stopMin    �ɲ�����,����ʱ�䣺��
-- scriptName ����,Ҫִ�е�����
local TimeTable = {
    {startHour = 23, startMin = 57, stopHour = 0, stopMin = 1, scriptName = "����������"},
    {startHour = 0, startMin = 2, scriptName = "һǧ��һ��Ը��"},
    {startHour = 0, startMin = 30, scriptName = "ˢ��"}
    -- ����ֻ��չʾ,�����Լ�����������ʱ�����,ÿ��Ҫ��Ӣ�Ķ��Ž���
}

while true do
    -- ��ȡ��ǰʱ��
    local nowH = tonumber(os.date("%H"))
    local nowM = tonumber(os.date("%M"))

    -- �жϽű�����
    for i = 1, #TimeTable do
        local tmp = TimeTable[i]
        -- ����н���ʱ���ҽ���ʱ�䵱ǰʱ�����ͬ
        if tmp.stopHour and tmp.stopMin and tmp.stopHour == nowH and tmp.stopMin == nowM then
            -- ��ȡ���ű���ǰ����ʲô
            GetConfig()
            if g_runing_script == tmp.scriptName then
                -- ֹͣ�ű�����
                PushColorMsg("���ű���ֹͣ��ʱ����" .. tmp.scriptName)
                MainStopRun(0)
            end
        end
    end

    -- �жϽű���ʼ
    for i = 1, #TimeTable do
        local tmp = TimeTable[i]
        -- �����ǰʱ�����ͬ
        if tmp.startHour == nowH and tmp.startMin == nowM then
            -- ��ȡ���ű���ǰ����ʲô
            GetConfig()
            if g_runing_script ~= tmp.scriptName then
                PushColorMsg("���ű���ִ�ж�ʱ����" .. tmp.scriptName)
                MainRunScript(tmp.scriptName) -- ���ҵ����ű�ִ�д˶�ʱ����
            end
            break
        end
    end

    -- 10����һ��
    Sleep(10 * 1000)
end
