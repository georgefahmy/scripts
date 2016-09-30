%% State Analysis
%%%%%%%%%
if exist('emb_state','var')
    emb_state.velocity = sqrt(emb_state.velocity_x.^2 +emb_state.velocity_y.^2);        
    emb_state.roll = atan2(2*(emb_state.rotation_w.*emb_state.rotation_x+emb_state.rotation_y.*emb_state.rotation_z),1-2*(emb_state.rotation_x.*emb_state.rotation_x+emb_state.rotation_y.*emb_state.rotation_y));
    emb_state.pitch = asin(2*(emb_state.rotation_w.*emb_state.rotation_y-emb_state.rotation_z.*emb_state.rotation_x));
    emb_state.yaw = atan2(2*(emb_state.rotation_w.*emb_state.rotation_z+emb_state.rotation_x.*emb_state.rotation_y),1-2*(emb_state.rotation_y.*emb_state.rotation_y+emb_state.rotation_z.*emb_state.rotation_z));
end
%%%%%%%%%
if exist('emb_state','var')
    dist1 = cumtrapz(sqrt((emb_state.velocity_x.^2) + (emb_state.velocity_y.^2) + (emb_state.velocity_z.^2))/100);
    flightdata.total_distance = dist1(end);
end
%%%%%%%%%
if exist('path_target','var')
    dist2 = cumtrapz(sqrt((path_target.velocity_x.^2) + (path_target.velocity_y.^2) + (path_target.velocity_z.^2))/100);
    flightdata.plan_distance = dist2(end);
end
%%%%%%%%%
if exist('emb_estimator','var')
    emb_estimator.roll = atan2(2*(emb_estimator.attitude_w.*emb_estimator.attitude_x+emb_estimator.attitude_y.*emb_estimator.attitude_z),1-2*(emb_estimator.attitude_x.*emb_estimator.attitude_x+emb_estimator.attitude_y.*emb_estimator.attitude_y));
    emb_estimator.pitch = asin(2*(emb_estimator.attitude_w.*emb_estimator.attitude_y-emb_estimator.attitude_z.*emb_estimator.attitude_x));
    emb_estimator.yaw = atan2(2*(emb_estimator.attitude_w.*emb_estimator.attitude_z+emb_estimator.attitude_x.*emb_estimator.attitude_y),1-2*(emb_estimator.attitude_y.*emb_estimator.attitude_y+emb_estimator.attitude_z.*emb_estimator.attitude_z));
end
%%%%%%%%%
if exist('emb_sensor','var')
    emb_sensor.total_g = sqrt(emb_sensor.accel_x.^2 + emb_sensor.accel_y.^2 + emb_sensor.accel_z.^2);
end
%%%%%%%%%
if exist('system_monitor','var')
    system_monitor.power = system_monitor.system_voltage.*-system_monitor.average_current;
end
%%%%%%%%%
if exist('path_target','var')
    path_target.velocity = sqrt(path_target.velocity_x.^2 +path_target.velocity_y.^2+path_target.velocity_z.^2);
end
%%%%%%%%%
if exist('poly2','var') && exist('emb_state','var')
    area = polyarea(poly2(:,1)*111319.458*(cosd(meta.home(2))),...
             poly2(:,2)*111319.458);% square meters
    flightdata.area = area*0.0002471054; %Acres   
end
%%%%%%%%%
 if exist('emb_controller','var') 
    emb_controller.leftyawmean = mean((emb_controller.throttle_w+emb_controller.throttle_y)./2);
    emb_controller.rightyawmean = mean((emb_controller.throttle_x+emb_controller.throttle_z)./2);
    emb_controller.frontmean = mean((emb_controller.throttle_w+emb_controller.throttle_x)./2);
    emb_controller.backmean = mean((emb_controller.throttle_y+emb_controller.throttle_z)./2);
    
    emb_controller.diff = (emb_controller.rightyawmean-emb_controller.leftyawmean)*4-.01;
    %positive is right bias, negative is left bias.

    end
%%%%%%%%%
 if exist('pos_con_telemetry','var') && exist('emb_state','var') && exist('emb_command','var') && exist('path_target','var')
     flightscore;
 end
%%%%%%%%%
 if exist('emb_mgmt','var') && length(emb_mgmt.bms_voltage) == length(emb_mgmt.bms_current)
    emb_mgmt.bms_power = emb_mgmt.bms_voltage.*-emb_mgmt.bms_current;
 end
%%%%%%%%%
if exist('emb_state','var') && emb_state.recv_timestamp(1) ~= emb_state.timestamp(1)
    emb_state.time_diff = emb_state.timestamp(1) - emb_state.recv_timestamp(1);
end
%%%%%%%%%
if exist('meta','var') && exist('gps_event','var')
   gps_event.translation_x2 = gps_event.translation_x - meta.home(2);
   gps_event.translation_x2 = gps_event.translation_x2 * 111319.458;
   
   gps_event.translation_y2 = gps_event.translation_y - meta.home(1);
   gps_event.translation_y2 = gps_event.translation_y2 *111319.458*(cosd(meta.home(2)));
end
if exist('geotags','var') && exist('meta','var')
    geotags.translation_x = (geotags.lat - meta.home(2))*111319.458;
    geotags.translation_y = (geotags.long - meta.home(1))*111319.458*(cosd(meta.home(2)));
end
