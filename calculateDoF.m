%该函数实现编码包自由度的计算
function dof = calculateDoF(slideWindow)

firstPkt = find(slideWindow==1,1,'first');

if isempty(firstPkt)
    dof = 0;
else
    
    lastPkt = find(slideWindow==1,1,'last');
    dof = lastPkt-firstPkt+1;
end
end

