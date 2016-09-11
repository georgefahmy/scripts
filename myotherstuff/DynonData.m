%% Dynon Data Analysis
% Create Time Vector
% find the length of the variables to determine length of time vector
x = whos;
x = mat2str(x(1).size);
x = x(2:end-3);
x = str2num(x);
x = x(1);
%create time vector
Time = 1:1:x;
Time = Time';
%divide the time vector by sample rate.
Time = Time/4;
clear x;

%% CHT, EGT and RPM

EGT = figure;
plot(Time,EGT1degC,Time,EGT2degC,Time,EGT3degC,Time,EGT4degC);
grid on;
xlabel ('Time (sec)');
ylabel ('Temperature (degC)');
legend ('EGT1','EGT2','EGT3','EGT4');
title ('Exhaust Gas Temps');

CHT = figure;
plot(Time,CHT1degC,Time,CHT2degC,Time,CHT3degC,Time,CHT4degC);
grid on;
xlabel ('Time (sec)');
ylabel ('Temperature (degC)');
legend ('CHT1','CHT2','CHT3','CHT4');
title ('Cylinder Head Temps');

RPM = figure;
plot(Time,RPML);
grid on;
xlabel ('Time (sec)');
ylabel ('Engine RPM');
legend ('RPM');
title ('Engine RPM');
