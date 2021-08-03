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
    
    %�޷���
    if t <= RTT
        %����������
        if judgeEW(slideWindow,k)
            %�ش�m��
            for i = 1:m
                %�ش�
                [slideWindow,packetMatrix(t,:),md(t),ad(t),t] = transmitTheSameRLNC(t,packetMatrix,RTT,channelState);                
            end
        else
            %�����µ���Ϣ��            
            [slideWindow,packetMatrix(t,:),md(t),ad(t),t] = addNewPkt(t,packetMatrix,RTT,channelState);
        end
    %����ΪNACK    
    elseif channelState(t-RTT) == 1
        error = error+1;
        if calculateCriterion(channelState,packetMatrix,error,t,md,ad,RTT)>th
            if ~judgeEW(slideWindow,k)
                if slideWindow(N) == 1
                    [slideWindow,packetMatrix(t,:),md(t),ad(t),t] = transmitTheSameRLNC(t,packetMatrix,RTT,channelState);
                else
                    %�����µ���Ϣ��
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
    %����ΪACK    
    else
        if judgeEW(slideWindow,k)
            m = ceil(k*error/(t-RTT));
            for i = 1:m
                [slideWindow,packetMatrix(t,:),md(t),ad(t),t] = transmitTheSameRLNC(t,packetMatrix,RTT,channelState);
            end
        end
        %��������ش�֮�󣬿����Ѿ��������
        if calculateDoF(slideWindow)>0
            
            if calculateCriterion(channelState,packetMatrix,error,t,md,ad,RTT)<th
                [slideWindow,packetMatrix(t,:),md(t),ad(t),t] = transmitTheSameRLNC(t,packetMatrix,RTT,channelState);
            elseif slideWindow(N) == 1
                %��û���µ���Ϣ�����Լ��룬�����仹û�н�����������ش�
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
        %û�д������
        if packetMatrix(t-1,N)  == 0
            [slideWindow,packetMatrix(t,:),md(t),ad(t),t] = addNewPkt(t,packetMatrix,RTT,channelState);
        end
        
    end
    
    %����Ϊ�յ���û�д������
    if calculateDoF(slideWindow) == 0 && packetMatrix(t-1,N)  == 0
        [slideWindow,packetMatrix(t,:),md(t),ad(t),t] = addNewPkt(t,packetMatrix,RTT,channelState);
    end
    
        
    
end

firstTransmitTime = calculateFirstTransmitTime(packetMatrix);

deliverTime = calculateDeliverTime(packetMatrix,RTT);
latency = deliverTime-firstTransmitTime;
meanLatency = mean(latency);

end