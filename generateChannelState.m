function channelState = generateChannelState(n,p,channelState)
for i = 1:n
    Pr = rand;
    if Pr < p
        channelState(i) = 1;
    end
end
end

