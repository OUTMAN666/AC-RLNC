function criterion = calculateCriterion(channelState,packetMatrix,error,t,md,ad,RTT)
%criterion = r - d
%r = 1 - error/(t-RTT)
%d = md./ad

%根据反馈信息更新md的值md(t)

r(t) = 1 - error/(t-RTT);
%md是这一时刻的
md(t) = calculateMd(t,packetMatrix,RTT,channelState);
%ad是上一时刻的
if ad(t-1) == 0
    d(t) = 0;
else    
    d(t) = md(t)/ad(t-1);
end
criterion = r(t)-d(t);

end

