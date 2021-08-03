%该函数实现ad值的更新，每次只更新当前时隙t
%ad是当前窗体中重传的次数
%输出：t时刻ad值
function currentAd = calculateAd(t,packetMatrix)

firstPkt = find(packetMatrix(t,:),1,'first');

%有重叠部分的第一个编码包
lowCode = find(packetMatrix(:,firstPkt),1,'first');
%ad值初始化为0
flag = 0;
%统计重传的次数
for i = lowCode:t
    %数组越界的情况
    if i == 1
        flag = 0;
    elseif isequal(packetMatrix(i,:),packetMatrix(i-1,:))
        flag = flag+1;
    end
end
currentAd = flag;
end
