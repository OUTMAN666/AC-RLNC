function criterion = calculateCriterion(channelState,packetMatrix,error,t,md,ad,RTT)
%criterion = r - d
%r = 1 - error/(t-RTT)
%d = md./ad

%���ݷ�����Ϣ����md��ֵmd(t)

r(t) = 1 - error/(t-RTT);
%md����һʱ�̵�
md(t) = calculateMd(t,packetMatrix,RTT,channelState);
%ad����һʱ�̵�
if ad(t-1) == 0
    d(t) = 0;
else    
    d(t) = md(t)/ad(t-1);
end
criterion = r(t)-d(t);

end

