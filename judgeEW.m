%¸Ãº¯ÊıÅĞ¶Ï»¬¶¯´°¿ÚÊÇ·ñÂú£¬EW=1ÎªÂú´°
function EW = judgeEW(slideWindow,k)
firstPkt = find(slideWindow==1,1,'first');

if isempty(firstPkt)
    EW = 0;
else
    lastPkt = find(slideWindow==1,1,'last');
    windowSize = lastPkt-firstPkt+1;
    if mod(lastPkt,k)==0  && windowSize>=k
        EW = 1;
    else
        EW = 0;
    end
end

end

