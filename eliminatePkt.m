%�ú���ʵ�ַ��Ͷ��ڻ�����������ȥ�Ѿ��������Ϣ��
%���룺��������ڴ�֮ǰ��״��
%�������ǰʱ϶��ʼʱ�̻������ڵ�״��
%���������ȥ���������һʱ϶��ʼʱ��������״��
%t-
function slideWindow = eliminatePkt(t,channelState,packetMatrix,RTT)
%��һʱ϶��������
lastWindow = packetMatrix(t-1,:);
%���Ͷ˿ɹ۲�Ľ���״��
AckWindow = packetMatrix(t-RTT,:);
currentMd = calculateMd(t,packetMatrix,RTT,channelState);
if channelState(t-RTT) == 0 && currentMd == 0
    slideWindow = lastWindow-AckWindow;  
    slideWindow(slideWindow<0) = 0;
else
    slideWindow = lastWindow;
end
end



