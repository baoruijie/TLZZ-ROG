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
PushColorMsg("���ű������ִ�жӳ�������,��ش������Զ���Ŀ¼")
while true do
    local leader, isleader = Team:GetLeaderInfo() -- ��ȡ�ӳ���Ϣ
    if leader and not isleader then -- �õ��ӳ���Ϣ���Լ����Ƕӳ�
        local leaderScript = GetLocalPlayerScript(leader.name) -- �öӳ������ƴ����ػ�ȡִ�е�����

        -- ��ȡ���Լ�����ִ�еĽű�,������ g_runing_script
        GetConfig()

        if leaderScript == "" then
            -- �ӳ�û��ִ��ʲô���񡢻������ػ�û��ˢ�¶ӳ�������
            if g_runing_script ~= "" then
                PushColorMsg("�ӳ�û��ִ������,ִֹͣ��")
                MainStopRun(1) -- �������ű�ֹͣ����,1��ʾֹͣ��Ҳ��ִ���б�����
            end
        else
            -- �����еĽű��Ͷӳ���һ��
            if g_runing_script ~= leaderScript then
                -- ��ȡ�ҵĵ�ͼID
                local selfScene = GetSceneID()

                -- �Ƿ����ִ�жӳ�������
                local bCanDo = true

                if IsInFubenScene(leader.sceneID) and leader.sceneID ~= 280 then -- �ų���˹ų�
                    if leader.sceneID ~= selfScene then
                        DebugStr("�ӳ��ڸ�����ͼ,�ݲ�ִ�жӳ�����")
                        bCanDo = false -- �ӳ��ڸ�����ͼ,��ȴ���ڸ�����ͼ����ִ�жӳ�����
                    end
                end

                if IsInFubenScene(selfScene) then
                    if leader.sceneID ~= selfScene then
                        DebugStr("���ڸ�����ͼ,�ݲ�ִ�жӳ�����")
                        bCanDo = false -- ���ڸ�����ͼ,�ӳ����ڸ�����ͼ����ִ�жӳ�����
                    end
                end
                if bCanDo then
                    PushColorMsg("�ӳ��������У�" .. leaderScript .. " �������еĲ�һ�£�" .. g_runing_script)
                    MainRunScript(leaderScript) -- ���ҵ����ű�ִ�жӳ�������
                end
            end
        end
    end
    Sleep(3000)
end
