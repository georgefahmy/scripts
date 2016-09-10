%% Save _results file

if length(fieldnames(flightdata)) > 5
flightdata.flightid = str2double(flightid);
%flightdata.flight_score = 100 - flightdata.path_error;
end

if 1

    %defining new data values for flightdata
    if ~exist('flightdate','var')
        unixtodate(flightid);
        flightdata.flightdate = flightdate;
    else
        flightdata.flightdate = flightdate;
    end
    if exist('emb_mgmt','var') && length(emb_mgmt.bms_current) > 2
        flightdata.current = mean(emb_mgmt.bms_current);
        flightdata.start_voltage = mean(emb_mgmt.bms_voltage(1:5));
        flightdata.end_voltage = mean(emb_mgmt.bms_voltage(end-5:end));
    end
    if exist('signal','var')
        flightdata.ave_rssi = mean(signal);
    elseif exist('command_interface_status','var')
        [time, signal] = interpOp(command_interface_status.recv_timestamp(2:end),command_interface_status.serial_signal_strength(2:end),emb_state.timestamp(2:end),emb_state.timestamp(2:end),'');
        flightdata.ave_rssi = mean(signal);
    else
        flightdata.ave_rssi = 0;
    end
    if exist('emb_state','var') && isfield(meta,'z_alt')
        flightdata.ave_height = mean(-emb_state.translation_z(-emb_state.translation_z > (max(-emb_state.translation_z)-5)))+meta.z_alt;
    else
        flightdata.ave_height = mean(-emb_state.translation_z(-emb_state.translation_z > (max(-emb_state.translation_z)-5)));
    end
    if ~isfield(flightdata,'flightid')
        flightdata.flightid = flightid;
    end
    if ~isfield(flightdata,'totaltime')
        flightdata.totaltime = 0;
    end
    if ~isfield(flightdata,'plan_distance')
        flightdata.plan_distance = 0;
    end
    if ~isfield(flightdata,'area')
        flightdata.area = 0;
    end
    if ~isfield(flightdata,'rssi')
        flightdata.rssi = 0;
    end
    if ~isfield(flightdata,'max_dist')
        dist = sqrt(emb_state.translation_x.^2+emb_state.translation_y.^2);
        dist = dist(1:end-1);
        flightdata.max_dist = max(dist);
    end
    if ~isfield(flightdata,'start_voltage')
        flightdata.start_voltage = 0;
    end
    if ~isfield(flightdata,'end_voltage')
        flightdata.end_voltage = 0;
    end
    if ~isfield(flightdata,'average_current')
        flightdata.average_current = 0;
    end
    if ~isfield(flightdata,'fly_id') && isfield(meta,'fly_id')
        flightdata.fly_id = meta.fly_id;
    else
        flightdata.fly_id = ' ';
    end
   
%results2 = [pathname '/_results/' '_results.txt'];
results3 = [pathname '/_results.txt'];
if isempty(desc)
    desc{1} = '';
end
if ~exist('score','var')
    if exist('pos_con_telemetry','var') && exist('emb_state','var') && exist('emb_command','var') && exist('path_target','var')
        flightscore;
        %flight_score = flightscore(emb_state,emb_command,pos_con_telemetry,path_target);
    else
        score.pos_con_score = 0;
        score.calculated_score = 0;
        score.tolerance_score = 0;
    end
end

%fid = fopen(results2,'wt+');
fid2 = fopen(results3,'wt+');
    
formatspec = [
                '%s \n'... %drone
                '%s \n\n'... %flightdate
                '%s \n\n'... %description of flight
                'Flight Score: %.2f \n\n'... %calculated flight score
                'Fly Id (if known): %s \n' ... %if downloaded from fly this will be saved
                'Flight ID: %s \n'... %flightid
                'Total time: %.2f minutes \n' ... %total time
                'Capture Area: %.2f Acres \n' ... %capture area
                'Starting Voltage: %.2f volts \n' ... %starting voltage
                'Ending Voltage: %.2f volts \n' ... %ending voltage
                'Average Current: %.2f amps \n' ... %average current
                'Average RSSI: %.2f \n' ... %average rssi
                'Max Distance from home: %.0f meters\n' ... %max distance
                'Planned Distance: %.2f meters\n'... %total distance
                'Distance Traveled: %.1f meters\n' ... %distance the drone traveled
                'Drone Height: %.0f Meters, %.0f Feet\n' ... %drone height
             ];

         
fprintf(fid2,formatspec,...%this fprintf's the fid and the formatspec above
drone,...
flightdata.flightdate,...
desc{1},...
score.tolerance_score,...
flightdata.fly_id,...
flightdata.flightid,...
flightdata.totaltime,...
flightdata.area,...
flightdata.start_voltage,...
flightdata.end_voltage,...
flightdata.average_current,...
flightdata.rssi,...
flightdata.max_dist,...
flightdata.plan_distance,...
flightdata.total_distance,...
flightdata.ave_height,...
flightdata.ave_height*3.28084);

fprintf(fid2,'\nsw version: %s\n',meta.swversion);
 
    
    fclose(fid2);
    fprintf('Saved results file\n');
          
end