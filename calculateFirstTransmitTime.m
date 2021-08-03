% 该函数记录每个信息包第一次发送的时刻
function firstTransmitTime = calculateFirstTransmitTime(packetMatrix)
n = size(packetMatrix,2);
firstTransmitTime = zeros(1,n);
for j = 1:n
firstTransmitTime(1,j) = find(packetMatrix(:,j)==1,1,'first');
end
end

