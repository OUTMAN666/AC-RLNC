%�ú���ʵ��adֵ�ĸ��£�ÿ��ֻ���µ�ǰʱ϶t
%ad�ǵ�ǰ�������ش��Ĵ���
%�����tʱ��adֵ
function currentAd = calculateAd(t,packetMatrix)

firstPkt = find(packetMatrix(t,:),1,'first');

%���ص����ֵĵ�һ�������
lowCode = find(packetMatrix(:,firstPkt),1,'first');
%adֵ��ʼ��Ϊ0
flag = 0;
%ͳ���ش��Ĵ���
for i = lowCode:t
    %����Խ������
    if i == 1
        flag = 0;
    elseif isequal(packetMatrix(i,:),packetMatrix(i-1,:))
        flag = flag+1;
    end
end
currentAd = flag;
end
