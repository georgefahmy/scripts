%% Position plots with error
positionx = figure('Name','position_x','WindowStyle','docked');
hold on;


if exist('pos_con_telemetry','var')
    pos_x_error = pos_con_telemetry.pos_x_con_telem_ref - pos_con_telemetry.pos_x_con_telem_meas;
    plot(pos_con_telemetry.recv_timestamp,pos_con_telemetry.pos_x_con_telem_ref);
    plot(gps_state.recv_timestamp,gps_state.translation_x);
    plot(emb_state.recv_timestamp,emb_state.translation_x);
    plot(pos_con_telemetry.recv_timestamp,pos_x_error);
    plot(pos_con_telemetry.recv_timestamp,pos_con_telemetry.pos_x_con_telem_output);
    legend('position target','gps state position','emb state position','position error','position output');

elseif dronetype == 0
    plot(high_controller_diag_commands.recv_timestamp,high_controller_diag_commands.translation_command_x);
    plot(gps_state.timestamp,gps_state.translation_x);
    plot(emb_state.timestamp,emb_state.translation_x);    
    legend('position_target','gps state position','emb state position');
   
end
  
grid on;
xlabel('time (sec)');
ylabel('position x');

%%
positiony = figure('Name','position_y','WindowStyle','docked');
hold on;

if exist('pos_con_telemetry','var')
    pos_y_error = pos_con_telemetry.pos_y_con_telem_ref - pos_con_telemetry.pos_y_con_telem_meas;
    plot(pos_con_telemetry.recv_timestamp,pos_con_telemetry.pos_y_con_telem_ref,'DisplayName','Target Position');
    plot(gps_state.recv_timestamp,gps_state.translation_y,'DisplayName','GPS State position');
    plot(emb_state.recv_timestamp,emb_state.translation_y,'DisplayName','emb state position');
    plot(pos_con_telemetry.recv_timestamp,pos_y_error,'DisplayName','position error');
    plot(pos_con_telemetry.recv_timestamp,pos_con_telemetry.pos_y_con_telem_output,'DisplayName','position output (m/s)');
    legend('-DynamicLegend');

elseif dronetype == 0
    plot(high_controller_diag_commands.recv_timestamp,high_controller_diag_commands.translation_command_y,'DisplayName','target position');
    plot(gps_state.timestamp,gps_state.translation_y,'DisplayName','gps state position');
    plot(emb_state.timestamp,emb_state.translation_y,'DisplayName','emb state position');
    legend('-DynamicLegend');
end

grid on;
xlabel('time (sec)');
ylabel('position y');

%%
positionz = figure('Name','position_z','WindowStyle','docked');
hold on;

if exist('pos_con_telemetry','var')
    pos_z_error = pos_con_telemetry.pos_z_con_telem_ref - pos_con_telemetry.pos_z_con_telem_meas;
    plot(pos_con_telemetry.recv_timestamp,pos_con_telemetry.pos_z_con_telem_ref);
    plot(gps_state.recv_timestamp,gps_state.translation_z);
    plot(emb_state.recv_timestamp,emb_state.translation_z);
    plot(pos_con_telemetry.recv_timestamp,pos_z_error);
    plot(pos_con_telemetry.recv_timestamp,pos_con_telemetry.pos_z_con_telem_output);
    plot(sensor_x86.recv_timestamp,sensor_x86.pos_z);
    legend('position target','gps state position','emb state position','position error','position output','sensor x86');

elseif dronetype == 0
    plot(high_controller_diag_commands.recv_timestamp,high_controller_diag_commands.translation_command_z);
    plot(gps_state.recv_timestamp,gps_state.translation_z);
    plot(emb_state.recv_timestamp-0.0,emb_state.translation_z);
    legend('target position','gps state position','emb state position');
end

grid on;
xlabel('time (sec)');
ylabel('position z');

%velint = cumtrapz(gps_state.timestamp,gps_state.velocity_z);
%plot(gps_state.timestamp,velint+gps_state.translation_z(1));
%plot(x86_sensor.timestamp,x86_sensor.pos_z)
if exist('positionx','var') && exist('positiony','var') && exist('positionz','var')
posexecute = 1;
end
