%�ú���ʵ�ֽ���ʱ��ļ���
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
%���ն��ܹ��ɹ������ʱ��
deliverTime = deliverTime -RTT/2;
end

