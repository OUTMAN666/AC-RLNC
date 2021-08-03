%�ú���ʵ��mdֵ�ĸ��£�ÿ��ֻ���µ�ǰʱ϶md(t)
%md��ֵ�ǽ��t-RTTʱ�̱����������Ҫ�����ɶ���Ŀ
function currentMd = calculateMd(t,packetMatrix,RTT,channelState)
currentMd = 0;
if t <= RTT
    currentMd = 0;
else
    %��t-RTT�н����Ŀ�ʼ�����ʱ϶
    firstPacket = find(packetMatrix(t-RTT,:)==1,1,'first');
    startSlot = find(packetMatrix(:,firstPacket)==1,1,'first');
    %ͳ�Ʒ���������ʱ϶��������Ϊmd
    for j = startSlot:t-RTT
        if j == 1
            currentMd = channelState(j);
        elseif channelState(j)==1 && ~isequal(packetMatrix(j,:),packetMatrix(j-1,:))
            currentMd = currentMd+1;
        elseif channelState(j)==0 && isequal(packetMatrix(j,:),packetMatrix(j-1,:))
            currentMd = currentMd-1;
        end
    end
end
if currentMd<0
    currentMd = 0;
end
end