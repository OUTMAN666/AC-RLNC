%该函数实现md值的更新，每次只更新当前时隙md(t)
%md的值是解出t-RTT时刻编码包，还需要的自由度数目
function currentMd = calculateMd(t,packetMatrix,RTT,channelState)
currentMd = 0;
if t <= RTT
    currentMd = 0;
else
    %与t-RTT有交集的开始编码包时隙
    firstPacket = find(packetMatrix(t-RTT,:)==1,1,'first');
    startSlot = find(packetMatrix(:,firstPacket)==1,1,'first');
    %统计符合条件的时隙数量，即为md
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