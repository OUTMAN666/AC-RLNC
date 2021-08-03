function [meanLatency,deliverTime,packetMatrix] = getACRLNC(th,N,RTT,p)

m = 1;

channelState = zeros(1,20*N);
channelState = generateChannelState(20*N,p,channelState);


k = RTT-1;
error = 0;
omax = 2*k;
slideWindow = zeros(1,N);
packetMatrix = zeros(20*N,N);
md = zeros(1,20*N);
ad = zeros(1,20*N);

slideWindow(1) = 1;
packetMatrix(1,:) = slideWindow;


t = 2;


while calculateDoF(slideWindow)>0
    
    %无反馈
    if t <= RTT
        %滑动窗口满
        if judgeEW(slideWindow,k)
            %重传m次
            for i = 1:m
                %重传
                [slideWindow,packetMatrix(t,:),md(t),ad(t),t] = transmitTheSameRLNC(t,packetMatrix,RTT,channelState);                
            end
        else
            %加入新的信息包            
            [slideWindow,packetMatrix(t,:),md(t),ad(t),t] = addNewPkt(t,packetMatrix,RTT,channelState);
        end
    %反馈为NACK    
    elseif channelState(t-RTT) == 1
        error = error+1;
        if calculateCriterion(channelState,packetMatrix,error,t,md,ad,RTT)>th
            if ~judgeEW(slideWindow,k)
                if slideWindow(N) == 1
                    [slideWindow,packetMatrix(t,:),md(t),ad(t),t] = transmitTheSameRLNC(t,packetMatrix,RTT,channelState);
                else
                    %加入新的信息包
                    [slideWindow,packetMatrix(t,:),md(t),ad(t),t] = addNewPkt(t,packetMatrix,RTT,channelState);
                end
            else
                m = ceil(k*error/(t-RTT));
                for i = 1:m
                [slideWindow,packetMatrix(t,:),md(t),ad(t),t] = transmitTheSameRLNC(t,packetMatrix,RTT,channelState);                
                end
            end
        else
            [slideWindow,packetMatrix(t,:),md(t),ad(t),t] = transmitTheSameRLNC(t,packetMatrix,RTT,channelState);
            
            if calculateDoF(slideWindow)>0
                if judgeEW(slideWindow,k)
                    m = ceil(k*error/(t-RTT));
                    for i = 1:m
                        [slideWindow,packetMatrix(t,:),md(t),ad(t),t] = transmitTheSameRLNC(t,packetMatrix,RTT,channelState);
                    end
                end
            end
            
        end      
    %反馈为ACK    
    else
        if judgeEW(slideWindow,k)
            m = ceil(k*error/(t-RTT));
            for i = 1:m
                [slideWindow,packetMatrix(t,:),md(t),ad(t),t] = transmitTheSameRLNC(t,packetMatrix,RTT,channelState);
            end
        end
        %在上面的重传之后，可能已经传输完毕
        if calculateDoF(slideWindow)>0
            
            if calculateCriterion(channelState,packetMatrix,error,t,md,ad,RTT)<th
                [slideWindow,packetMatrix(t,:),md(t),ad(t),t] = transmitTheSameRLNC(t,packetMatrix,RTT,channelState);
            elseif slideWindow(N) == 1
                %若没有新的信息包可以加入，而传输还没有结束，则继续重传
                [slideWindow,packetMatrix(t,:),md(t),ad(t),t] = transmitTheSameRLNC(t,packetMatrix,RTT,channelState);
            else
                [slideWindow,packetMatrix(t,:),md(t),ad(t),t] = addNewPkt(t,packetMatrix,RTT,channelState);
            end
            
        end
    end
    
    if calculateDoF(slideWindow)>omax
        while calculateDoF(slideWindow) ~= 0
            [slideWindow,packetMatrix(t,:),md(t),ad(t),t] = transmitTheSameRLNC(t,packetMatrix,RTT,channelState);
        end
        %没有传输完毕
        if packetMatrix(t-1,N)  == 0
            [slideWindow,packetMatrix(t,:),md(t),ad(t),t] = addNewPkt(t,packetMatrix,RTT,channelState);
        end
        
    end
    
    %窗体为空但还没有传输完毕
    if calculateDoF(slideWindow) == 0 && packetMatrix(t-1,N)  == 0
        [slideWindow,packetMatrix(t,:),md(t),ad(t),t] = addNewPkt(t,packetMatrix,RTT,channelState);
    end
    
        
    
end

firstTransmitTime = calculateFirstTransmitTime(packetMatrix);

deliverTime = calculateDeliverTime(packetMatrix,RTT);
latency = deliverTime-firstTransmitTime;
meanLatency = mean(latency);

end