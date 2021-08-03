%�ú���ʵ�ּ����µ���Ϣ��������
%�������ǰʱ��Ԥ������ı����
function [realSlideWindow,slideWindow,md,ad,time] = addNewPkt(t,packetMatrix,RTT,channelState)

if t <=RTT
    lastPkt = find(packetMatrix(t-1,:)==1,1,'last');
    lastPkt = lastPkt+1;
    packetMatrix(t,:) = packetMatrix(t-1,:);
    packetMatrix(t,lastPkt) = 1;
    slideWindow = packetMatrix(t,:);
    realSlideWindow = slideWindow;
    md = calculateMd(t,packetMatrix,RTT,channelState);
    ad = calculateAd(t,packetMatrix);
    time = t+1;
else
    slideWindow = eliminatePkt(t,channelState,packetMatrix,RTT);
    packetMatrix(t,:) = slideWindow;
    lastPkt = find(slideWindow==1,1,'last');
    
    %��������Ϊ��
    if isempty(lastPkt)
        %ǰһʱ�����һ�����ݰ���һ��
        slideWindow(find(packetMatrix(t-1,:)==1,1,'last')+1) = 1;
    else
        lastPkt = lastPkt+1;
        packetMatrix(t,lastPkt) = 1;
        slideWindow = packetMatrix(t,:);
    end
    %���´������
    packetMatrix(t,:) = slideWindow;
    
    md = calculateMd(t,packetMatrix,RTT,channelState);
    ad = calculateAd(t,packetMatrix);
    time = t+1;
    %�����µ���Ϣ��֮��������ȥ������ʵ����
    realSlideWindow = eliminatePkt(time,channelState,packetMatrix,RTT);
    
    
end


end

