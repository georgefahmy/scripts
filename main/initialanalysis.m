%% first analysis functions

if exist('meta','var') && length(meta) >= 20
        [poly, home, meta] = meta_data_analysis(meta);
end

if exist('sensor','var')
    sensor = sensor_data_analysis(sensor);
end
    
        if length(fieldnames(emb_sensor)) > 10 && dronetype 
               if ~exist('amb_temp');
                    amb_temp = inputdlg('Enter Ambient Temperature, if unknown enter 0: ');
                    [amb_temp, check] = str2num(amb_temp{1});%this is to calibrate for the ambient temperature difference 
               end
               
               if ~check
                   amb_temp = 0;
               end

            if amb_temp <= 38
                amb_temp;
            elseif amb_temp>38
                amb_temp = (5/9)*(amb_temp-32);
            end
        end
        
areacalc;
droneheight;
throttleanalysis;
stateanalysis;

%Discription of flight
if ~exist('desc')
desc = inputdlg('Enter a description of the flight','Description',2);
end
