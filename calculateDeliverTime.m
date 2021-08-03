%该函数实现解码时间的计算
function deliverTime = calculateDeliverTime(packetMatrix,RTT)
j = 1;
n = size(packetMatrix,2);
deliverTime = zeros(1,n);
while sum(packetMatrix(j,:)) > 0
    neibourghhood = packetMatrix(j+1,:)-packetMatrix(j,:);
    indexTime = neibourghhood<0;
    deliverTime(indexTime) = j+1;
    j = j+1;
end
%接收端能够成功解码的时刻
deliverTime = deliverTime -RTT/2;
end

