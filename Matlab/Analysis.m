clear all, close all, clc


[l, fs] = audioread('Left.wav');
[r, fs] = audioread('Right.wav');

l = l(34000:40000);
r = r(34000:40000);

%%


indxL = findFirstTransient(l, -40);
indxR = findFirstTransient(r, -40);
[xC, lag] = xcorr(l, r);
d = finddelay(l, r);

a = 0.99;
b = 100 * (1 - a);

lF = filter(b, [1, -a], l.^2);
rF = filter(b, [1, -a], r.^2);




%%

close all;

subplot(311);
plot(l);
hold on;
scatter(indxL, db2mag(-60));
plot(lF);
ylim([-1, 1])




subplot(312)
plot(r)
hold on;
scatter(indxR, db2mag(-60));
plot(rF);
ylim([-1, 1])


subplot(313);
plot(lag, xC)


