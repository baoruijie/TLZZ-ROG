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
PushColorMsg("���ű�������ʵʱ��Ѫ,��ش������Զ���Ŀ¼")

-- ��ȡ����,��ȡһ���û����õļ�Ѫ�����,�Ͳ����ظ���ȡ��
GetConfig()

-- ��ȡ�Լ����������ֵȱ����� g_self ��
PlayerDataInit()

-- ����ȡ�������ý�����CDG
CommonParamInit("")

-- ���趨�Ƽ�Ѫ����,�ɽ������/�༭����Ĵ���
-- CDG.hp.em_firstlist_name = "" -- ���ȼ�Ѫ�б�ȡ��
-- CDG.hp.em_bh_self = false -- ����Ѫȡ��
-- CDG.hp.em_tm_self = false -- ͬ�˼�Ѫȡ��
-- CDG.hp.em_bh_id = "" -- ���ID��Ѫȡ��
-- CDG.hp.em_namelist = "" -- �����б��Ѫȡ��
-- CDG.hp.em_raid = false -- �ŶӼ�Ѫȡ��
-- CDG.hp.em_team = false -- �����Ѫȡ��

while true do
    -- ȷ�϶�����4
    if g_self.menpai == 4 then
        local nState = Player:GetState()
        -- ȷ�ϵ�ǰ�޶��������
        if nState == 0 then
            -- ȷ�ϵ�ǰû������
            if not IsMount() then
                -- not IsGuanShanHaiScene() ���ڹ�ɽ����ͼ,��Ϊ��ɽ��Ľ�ݸ���Ѫ��ָ��Լ���Ѫ��
                -- ȷ�ϲ��ڸ�����ͼ
                if not IsInFubenScene() then
                    -- ȷ��״̬�ܼ�Ѫ,���Ǵ��ͱ���
                    if Player:GetBuff("�޵�") == -1 and Player:GetBuff("����") == -1 then
                        local add_hp_name = CDG:checkHP_Player() -- ��Ѫ
                        if add_hp_name == "" then
                            CDG:checkHP(false) -- û�ҵ���Ѫ�����ٴμ����Լ���Ѫ
                        end
                        -- ����
                        CDG:checkMP(true)
                    end
                end
            end
        end
    end
    Sleep(500)
end
