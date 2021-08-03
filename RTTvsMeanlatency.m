
th = 0;
m = 1;
N = 100;
% channelState = [0 0 1 1,0 0 0 1,1 1 0 1,0 0 0 1 ...
%     1 0 0 0,1 1 0 1,0 0 1 1,1 1 0 0];
RTT = 5:5:30;
p = 0.2;
epoch = 1000;
meanLatency = zeros(1,epoch);

latency = zeros(1,6);
for RTT = 5:5:30
    for k = 1:epoch
        [meanLatency(k),deliverTime,packetMatrix] = getACRLNC(th,m,N,RTT,p);
        if meanLatency(k)<0
            flag = 1;
        end
    end
    latency(RTT/5) = mean(meanLatency);
end


