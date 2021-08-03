%该函数实现加入新的信息包并传输
%输出：当前时刻预备传输的编码包
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
    
    %滑动窗口为空
    if isempty(lastPkt)
        %前一时刻最后一个数据包后一个
        slideWindow(find(packetMatrix(t-1,:)==1,1,'last')+1) = 1;
    else
        lastPkt = lastPkt+1;
        packetMatrix(t,lastPkt) = 1;
        slideWindow = packetMatrix(t,:);
    end
    %更新传输矩阵
    packetMatrix(t,:) = slideWindow;
    
    md = calculateMd(t,packetMatrix,RTT,channelState);
    ad = calculateAd(t,packetMatrix);
    time = t+1;
    %加入新的信息包之后由于消去更新真实窗体
    realSlideWindow = eliminatePkt(time,channelState,packetMatrix,RTT);
    
    
end


end

