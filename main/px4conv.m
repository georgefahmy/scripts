%% matlab script to run python script to convert px4log to .csv
ccc;
startdir = '~/Documents/nostrel_files/Log_files';
cd(startdir);

pathname = uigetdir('Select Folder for Data');

%[file, pathname] = uigetfile('.px4log','Select the log file to convert');

if ~exist([pathname 'csv_files'],'dir')
    mkdir(pathname,'csv_files');
end

temp = dir(pathname);

for i = 3:length(temp)-1
    file = temp(i).name;

logfile = [pathname '/' file];

%the command string is the string that the system will execute, it includes
%all desired outputs from the logfile that will be includes in the CSV file 
if 1
    %this will only export chosen channels
    comStr = ['python ~/Documents/Projects/Matlab/Scripts/sdlog2_dump.py ' ...
               logfile  ' -t' ' TIME' ' -m' ' TIME' ' -m' ' IMU' ' -m' ' ATT' ...
               ' -m' ' ARSP' ' -m' ' ATSP' ' -m' ' BATT' ' -m' ' OUT0'...
               ' > ' pathname '/' 'csv_files/' file(1:end-7) '.csv'];
else
    %This will export all channels to the csv file
    comStr = ['python ~/Documents/Projects/Matlab/Scripts/sdlog2_dump.py ' ...
               logfile  ' -t' ' TIME' ...
               ' > ' pathname '/' 'csv_files/' file(1:end-7) '.csv']; 
end
       
% Example Message Types
 
% TIME - Time stamp
% ATT - Vehicle attitude
% ATSP - Vehicle attitude setpoint
% IMU - IMU sensors
% SENS - Other sensors
% LPOS - Local position estimate
% LPSP - Local position setpoint
% GPS - GPS position
% ATTC - Attitude controls (actuator_0 output)
% STAT - Vehicle state
% RC - RC input channels
% OUT0 - Actuator_0 output
% AIRS - Airspeed
% ARSP - Attitude rate setpoint
% FLOW - Optical flow
% GPOS - Global position estimate
% GPSP - Global position setpoint
% ESC - ESC state
% GVSP - Global velocity setpoint
% BATT - Battery channels
%

%this code executes the python code in the commandStr above. it converts
%the logfile from the .px4log log to a readable .csv file

[status, commandOut] = system(comStr);

if status == 0
    fprintf('Converted %s to CSV\n',logfile(end-31:end));
    clear csvlog;
end
end
csvlog = [pathname '/' 'csv_files/' file(1:end-7) '.csv']; %this is the name of the new file

%% Importing the csv file
if 0
    fid = fopen(csvlog);
else
    [csvlog, pathname] = uigetfile('.csv', 'Select the CSV file');
    csvlog = [pathname '/' csvlog];
    fid = fopen(csvlog);
    close all;
end
    
    headerline = fgetl(fid);    
    raw = textscan(headerline,'%s',49,'Delimiter',',');
       for i = 1:length(raw{1,1})
           var_headers{i,1} = genvarname(raw{1,1}{i,1});
       end
    clear raw ;
    fclose(fid);
    clear fid;
       
% Variables 

   fid = fopen(csvlog);

   raw = textscan(fid,'%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%n%[^\n\r]','HeaderLines',2,'Delimiter',',');
       for i = 1:length(raw)-1
          
               pxdata.(cell2mat(var_headers(i))) = cell2mat(raw(i));
          
       end
      pxdata.time = (pxdata.TIME_StartTime-pxdata.TIME_StartTime(1))/1000000;
       %pxdata.TIME_StartTime = pxdata.TIME_StartTime-pxdata.TIME_StartTime(1);
   fclose(fid);
   clearvars -except pathname logfile csvlog pxdata comStr status

%% Math

pxdata.rollerror = pxdata.ATSP_RollSP - pxdata.ATT_Roll;
pxdata.pitcherror = pxdata.ATSP_PitchSP - pxdata.ATT_Pitch;
pxdata.rrerror = pxdata.ARSP_RollRateSP - pxdata.ATT_RollRate;
pxdata.prerror = pxdata.ARSP_PitchRateSP - pxdata.ATT_PitchRate;

pxdata.throttle1 = movingmean(((pxdata.OUT0_Out0-1175)/750),1,1,2);
pxdata.throttle2 = movingmean(((pxdata.OUT0_Out1-1175)/750),1,1,2);
pxdata.throttle3 = movingmean(((pxdata.OUT0_Out2-1175)/750),1,1,2);
pxdata.throttle4 = movingmean(((pxdata.OUT0_Out3-1175)/750),1,1,2);

pxdata.rightave = (pxdata.throttle1 + pxdata.throttle4)/2;
pxdata.leftave = (pxdata.throttle2 + pxdata.throttle3)/2;

pxdata.u = (pxdata.OUT0_Out0-pxdata.OUT0_Out1)-...
               mean(pxdata.OUT0_Out0-pxdata.OUT0_Out1);
           pxdata.u = -pxdata.u;

%% Analysis

 figure;hold on;grid on;plot(pxdata.OUT0_Out0);plot(pxdata.OUT0_Out1);plot(pxdata.OUT0_Out2);plot(pxdata.OUT0_Out3)


%pitch angle
figure('Name','Pitch','WindowStyle','docked');
hold on;
plot(pxdata.ATT_Pitch)
plot(pxdata.ATSP_PitchSP)
plot(pxdata.pitcherror);
grid on;
xlabel('time (sec)');
ylabel('Rad');
legend('Angle','Angle Command','Angle Error');
title('Pitch');

%roll angle
figure('Name','Roll','WindowStyle','docked');
plot(pxdata.time,pxdata.ATT_Roll,pxdata.time,pxdata.ATSP_RollSP,pxdata.time,pxdata.rollerror);
grid on;
xlabel('time (sec)');
ylabel('Rad');
legend('Angle','Angle Command','Angle Error');
title('Roll');

%Pitch rate plot
figure('Name','Pitch Rate','WindowStyle','docked');
hold on;
plot(pxdata.time,pxdata.ATT_PitchRate)
plot(pxdata.time,pxdata.ARSP_PitchRateSP)
plot(pxdata.time,pxdata.prerror);
grid on;
xlabel('time (sec)');
ylabel('Rad/s');
legend('Rate','Rate Command','Rate Error');
title('Pitch Rate');

%roll rate plot
figure('Name','Roll Rate','WindowStyle','docked');
plot(pxdata.time,movingmean(pxdata.ATT_RollRate,5,1,2),pxdata.time,pxdata.ARSP_RollRateSP,pxdata.time,pxdata.rrerror);
grid on;
xlabel('time (sec)');
ylabel('Rad/s');
legend('Rate','Rate Command','Rate Error');
title('Roll Rate');

%yaw rate plot
figure('Name','Yaw Rate','WindowStyle','docked');
plot(pxdata.time,pxdata.ATT_YawRate,pxdata.time,pxdata.ARSP_YawRateSP);
grid on;
xlabel('time (sec)');
ylabel('Rad/s');
legend('Rate','Rate Command');
title('Yaw Rate');

%throttle splits for the individual motors
figure('Name','Throttle Split','WindowStyle','docked');
hold on;
plot(pxdata.throttle1);
plot(pxdata.throttle2);
plot(pxdata.throttle3);
plot(pxdata.throttle4);
grid on;
xlabel('time (sec)');
ylabel('throttle %');
legend('Right Front','Left Rear','Left Front','Right Rear');
title('Throttle Split');

% average left right motor throttle split
figure('Name','Average Throttle Split','WindowStyle','docked');
plot(pxdata.time,pxdata.leftave,pxdata.time,pxdata.rightave);
grid on;
xlabel('time (sec)');
ylabel('throttle %');
legend('left','right');
title('Throttle Split');

%battery current plot
figure('Name','Battery Current','WindowStyle','docked');
plot(pxdata.time,pxdata.BATT_C*1.16);
grid on;
xlabel('time (sec)');
ylabel('Current (amps)');
title('Battery Current');

%battery voltage plot
figure('Name','Battery Voltage','WindowStyle','docked');
plot(pxdata.time,pxdata.BATT_V);
grid on;
xlabel('time (sec)');
ylabel('Voltage (volts)');
title('Battery Voltage');

%battery power plot
figure('Name','Battery Power','WindowStyle','docked');
pxdata.BATT_P = pxdata.BATT_V.*(pxdata.BATT_C*1.16);
plot(pxdata.time,pxdata.BATT_P);
grid on;
xlabel('time (sec)');
ylabel('Power (w)');
title('Battery Power');

fprintf('flight time: %.1f\n',max(pxdata.time));
