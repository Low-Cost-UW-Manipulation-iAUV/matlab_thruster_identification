clc 
clear all
%% Thruster Identification

%  Using a Tedea No.1022 5kg load cell with a NovaTech 4211 Loadcell Amplifier (SY011 v 010 - 05 - 2.0). 
% Author: Raphael Nagel
% Date:   16/Sept/2014
% Done on 

g = 9.80665;

%Measurements: [kg ADCvalue]
zero_ref=[
      309;
      308;
];

adc_out_grams = [
    0.05*g  317;
    0.10*g  326;
    0.15*g  333;
    0.20*g  342;
    0.25*g  350;
    0.30*g  359;
    0.35*g  367;
    0.40*g  375;
    0.45*g  383;
    0.50*g 392;
    0.55*g 400;
    
    ];
%Measurements: [N ADCvalue]

adc_out_newtons=[
    1   326;
    2   342;
    3   360;
    4   377;
    5   394;
    6   410;
    7   427;
    ];
v_out = [adc_out_grams; adc_out_newtons];

% find offset
offset = sum(zero_ref)/length(zero_ref);

% remove the offset
clean = (v_out(:,2) - offset);

% remove the extra length of lever
% force / actual force applied
lever_factor = mean(clean ./ (v_out(:,1)));
 
cleaner_force = clean .* (1/lever_factor) 

kilograms = cleaner_force /g

disp('Solution: ');
offset
lever_factor
