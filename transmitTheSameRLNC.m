%该函数用于重传上一时隙编码包一次
function [realSlideWindow,slideWindow,md,ad,time] = transmitTheSameRLNC(t,packetMatrix,RTT,channelState)
%重传的窗体，也是传输矩阵的当前值
slideWindow = packetMatrix(t-1,:);
packetMatrix(t,:) = packetMatrix(t-1,:);
%更新重传决策之后当前的md(t),ad(t)值
md = calculateMd(t,packetMatrix,RTT,channelState);
ad = calculateAd(t,packetMatrix);

if t <= RTT-1
    realSlideWindow = slideWindow;
else
    %重传之后真实活动窗体
    realSlideWindow = eliminatePkt(t+1,channelState,packetMatrix,RTT);    
end
%更新当前时隙
time = t+1;
end

