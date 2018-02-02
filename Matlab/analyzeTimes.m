function d = analyzeTimes(dL, dR)
   
d = zeros(length(dL), 1);

state = 0;
counter = 0;

sw = (dL + dR) > 0;

for n = 1:length(sw)
    if sw(n) == 1
        if state == 0
            state = 1;
            counter = 0;
        else
            state = 0;
            d(n) = counter;
            counter = 0;
        end
    end
    
    if counter > 100
        state = 0;
        counter = 0;
    end
    
    if state == 1
        counter = counter + 1;
    end
end

end