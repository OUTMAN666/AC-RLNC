%该函数实现发送端在滑动窗口中消去已经解出的信息包
%输入：传输矩阵在此之前的状况
%输出：当前时隙开始时刻滑动窗口的状况
%如果不用消去，则输出这一时隙开始时滑动窗口状况
%t-
function slideWindow = eliminatePkt(t,channelState,packetMatrix,RTT)
%上一时隙滑动窗体
lastWindow = packetMatrix(t-1,:);
%发送端可观测的接收状况
AckWindow = packetMatrix(t-RTT,:);
currentMd = calculateMd(t,packetMatrix,RTT,channelState);
if channelState(t-RTT) == 0 && currentMd == 0
    slideWindow = lastWindow-AckWindow;  
    slideWindow(slideWindow<0) = 0;
else
    slideWindow = lastWindow;
end
end



