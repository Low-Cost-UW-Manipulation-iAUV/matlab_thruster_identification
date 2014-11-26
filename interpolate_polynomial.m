%% HOW DO I DO THAT IN MATLAB SERIES?
% In this series, I am answering questions that students have asked
% me about MATLAB.  Most of the questions relate to a mathematical 
% procedure.

%% TOPIC
% How do I do polynomial interpolation?

%% SUMMARY

% Language : Matlab 2008a; 
% Authors : Autar Kaw; 
% Mfile available at
% http://numericalmethods.eng.usf.edu/blog/interpolate_polynomial.m; 
% Last Revised : June 10, 2009; 
% Abstract: This program shows you how to do polynomial interpolation?
%           .
clc
clear all
clf

%% INTRODUCTION

disp('ABSTRACT')
disp('   This program shows you how to do polynomial interpolation?')
disp(' ')
disp('AUTHOR')
disp('   Autar K Kaw of http://autarkaw.wordpress.com')
disp(' ')
disp('MFILE SOURCE')
disp('   http://numericalmethods.eng.usf.edu/blog/interpolation_polynomial.m')
disp(' ')
disp('LAST REVISED')
disp('   June 10, 2009')
disp(' ')

%% INPUTS
% y vs x data to interpolate
% x data
x=[-1  -0.6  -0.2  0.2  0.6  1];
% ydata
y=[0.0385    0.1000    0.5000    0.6000    0.8000    1];
% Where do you want to interpolate at
xin=-100:1:100;
%% DISPLAYING INPUTS
disp('INPUTS')
disp('The x data')
x
disp('The y data')
y
disp('The x values where you want to find the interpolated values')
xin
disp('  ')

%% THE CODE
% Find the number of data points
n=length(x);
% Fitting to polynomial of order m=n-1
m=2
% pp consists of the coefficients of the polynomial 
% pp(1)*x^m+pp(2)*x^m+.......+pp(m)
% pp(1) is coefficient of x^m
% pp(2) is coefficient of x^(m-1)
% and so on
pp=polyfit(x,y,m);
% Getting the values at xin
yin=polyval(pp,xin);
% This is only for plotting the interpolating polynomial
xplot=x(1):(x(n)-x(1))/10000:x(n);
yplot=polyval(pp,xplot);

%% DISPLAYING OUTPUTS
disp('  ')
disp('OUTPUTS')
disp('x values at which function is to be interpolated')
xin
disp('y values at the xin values')
yin
disp('These are the coefficients of the polynomial interpolant')
disp('pp(1) is coefficient of x^m, pp(2) is coefficient of x^(m-1) and so on')
fprintf('Order of polynomial m =%g',m)
pp
xlabel('x');
ylabel('y');
title('y vs x ');
plot(x,y,'o','MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor','b')
hold on
plot(xin,yin,'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','k')
hold on
plot(xplot,yplot,'LineWidth',2)
legend('Points given','Points found','Polynomial Curve')
hold off
disp('  ')