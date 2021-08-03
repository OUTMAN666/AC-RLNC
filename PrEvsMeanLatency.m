
th = 0;
m = 1;
N = 100;
% channelState = [0 0 1 1,0 0 0 1,1 1 0 1,0 0 0 1 ...
%     1 0 0 0,1 1 0 1,0 0 1 1,1 1 0 0];
RTT = 6;

epoch = 1000;
meanLatency = zeros(1,epoch);


p = 0.5;

for k = 1:epoch
    [meanLatency(k),deliverTime,packetMatrix] = getACRLNC(th,m,N,RTT,p);
    if meanLatency(k)<0
        flag = 1;
    end
end
latency = mean(meanLatency);



