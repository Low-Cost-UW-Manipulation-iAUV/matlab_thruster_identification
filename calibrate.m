clc
close all
clear all
load('calibrate_vertical0:50:550gr.mat');

figure(100);
plot([message_data.value]);
figure(101);
hist([message_data(1:6400).value],100)