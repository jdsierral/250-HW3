clear all, close all, clc

[l, fs] = audioread('LeftP.wav');
[r, fs] = audioread('RightP.wav');

%%


tauFA = 1;
tauFR = 20;
tauS = 1000;

a1F = exp(-1/(fs * tauF / 1000.0));
b0F = 1 - a1F;

