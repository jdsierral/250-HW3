clear all, close all, clc

[l, fs] = audioread('LeftFF.wav');
[r, fs] = audioread('RightFF.wav');
% [l, fs] = audioread('LeftPFrac.wav');
% [r, fs] = audioread('RightPFrac.wav');


% l = l(85000:90000);
% r = r(85000:90000);

%%

close all;

tauF = 1;
tauS = 1000;

a1S = exp(-1/(fs * tauS / 1000.0));
b0S = 10 * (1 - a1S);


lYF = tracker(l, fs, 1, 10); 
rYF = tracker(r, fs, 1, 10); 
lYS = filter(b0S, [1, -a1S], abs(l));
rYS = filter(b0S, [1, -a1S], abs(r));

t = linspace(0, length(l)/fs, length(l));

subplot(211);
plot(t, l);
hold on;
plot(t, lYF);
plot(t, lYS);
% xlim([1.9, 2.1])


subplot(212)
plot(t, r);
hold on;
plot(t, rYF);
plot(t, rYS);
% xlim([1.9, 2.1])


%%

close all;

tL = lYF > lYS;
tR = rYF > rYS;

dL = diff(tL);
dR = diff(tR);

dL(dL == -1) = 0;
dR(dR == -1) = 0;

dL = [dL; 0];
dR = [dR; 0];


plot(t, dL);
hold on;
plot(t, dR);
% xlim([1.9, 2.0]);

%%

close all

% dL = dL(50000:end);
% dR = dR(50000:end);

delays = analyzeTimes(dL, dR);

subplot(211)
plot(delays)
subplot(212)
plot(dL);
hold on
plot(dR);

%%





