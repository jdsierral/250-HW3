function y = tracker(x, fs, tauAttack, tauRelease) 

a1A = exp(-1/(fs * tauAttack / 1000.0));
b0A = 1 - a1A;

a1R = exp(-1/(fs * tauRelease / 1000.0));
b0R = 1 - a1R;



s = 0;

y = zeros(size(x));

for n = 1:length(x)
    if abs(x(n)) > s
        s = s + b0A * ( abs(x(n)) - s );
    else
        s = s + b0R * ( abs(x(n)) - s );
    end
    y(n) = s;
end


end