%�ú��������ش���һʱ϶�����һ��
function [realSlideWindow,slideWindow,md,ad,time] = transmitTheSameRLNC(t,packetMatrix,RTT,channelState)
%�ش��Ĵ��壬Ҳ�Ǵ������ĵ�ǰֵ
slideWindow = packetMatrix(t-1,:);
packetMatrix(t,:) = packetMatrix(t-1,:);
%�����ش�����֮��ǰ��md(t),ad(t)ֵ
md = calculateMd(t,packetMatrix,RTT,channelState);
ad = calculateAd(t,packetMatrix);

if t <= RTT-1
    realSlideWindow = slideWindow;
else
    %�ش�֮����ʵ�����
    realSlideWindow = eliminatePkt(t+1,channelState,packetMatrix,RTT);    
end
%���µ�ǰʱ϶
time = t+1;
end

