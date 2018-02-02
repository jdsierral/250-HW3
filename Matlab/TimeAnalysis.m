% Time analysis of dipole system % 


clear all, close all, clc


[l, fs] = audioread('Left.wav');
[r, fs] = audioread('Right.wav');

tL = zeros(length(l), 1);
tR = zeros(length(l), 1);

sL = 0.0;
sR = 0.0;

tau = 100/1000; 

a = exp(-1/(fs * tau));
b = 100 * (1-a);

att = zeros(length(l), 2);

for n = (1:length(l))
    sL = sL + b * (abs(l(n)) - sL);
    sR = sR + b * (abs(r(n)) - sR);
    
    tL(n) = sL;
    tR(n) = sR;
    
    if (sL > 0.1) 
        att(n, 1) = 0.5;
    end
    
    if (sR > 0.1)
        att(n, 2) = 0.5;
    end
end

t = linspace(0, (length(l)/fs), length(l));

subplot(211);
plot(t, l);
hold on;
plot(t, tL + 1);
scatter(t, att(:,1), '.');


subplot(212);
plot(t, r);
hold on;
plot(t, tR + 1);
scatter(t, att(:,2), '.');



