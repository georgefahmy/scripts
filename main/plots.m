%%
close all;
%plotselector;


%% RSSI plots

    rssi;

    
%% Position Plots

    positions;

    
%% Velocity Plots

    velocities;
    
    
%% Attitude Controller

    att_con_telem_filter_val = 1;
    att_rate_con_telem_filter_val = 1;
    
    attcon;

%% Mag plot 
 
    mag;

%% Attitude Estimator
 
    atti;
    
%% Throttle Plots
 
    throttles;

%% System Monitor data (temperatures)
 
    temps;

    
%% Battery Management System
 
    bms;


%% Path Overlay Plot
 
    overlaypath;

    
%% Gyro and Accel
    
    gyro_filter_val = 1;

    gyroaccel;


%% Baro      
 
    barogps;


%% Heading
 
    quiverheading;

    
%% CPU Info
 
    cpu;

    
%% GPS Info
 
    gpsinfo;

%% FlightScore Plot

    flightscore;
    
%% Playback    
    %this is disabled unless manually chosen to play it.
    pathplayback;
    
%% Grounddetector

    grounddetector;
    

