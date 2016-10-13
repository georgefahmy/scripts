%% Velocity Plots
%%%%%%%%%%
if exist('pos_con_telemetry','var')
    velocityx = figure('Name','velx','WindowStyle','docked');
    hold on;
    grid on;
    vel_x_error = pos_con_telemetry.vel_x_con_telem_ref - pos_con_telemetry.vel_x_con_telem_meas;
    
    plot(pos_con_telemetry.recv_timestamp,pos_con_telemetry.vel_x_con_telem_ref);
    plot(gps_state.recv_timestamp,gps_state.velocity_x);
    plot(emb_state.recv_timestamp,emb_state.velocity_x);
    plot(pos_con_telemetry.recv_timestamp,vel_x_error);
    plot(pos_con_telemetry.recv_timestamp,pos_con_telemetry.vel_x_con_telem_output);
    xlabel('time (sec)');
    ylabel('velocity (m/s)');
    legend('planned velocity','gps state velocity','emb state velocity','vel error','vel output');
else ~dronetype
    velocityx = figure('Name','velx','WindowStyle','docked');
    hold on;
    grid on;
    plot(high_controller_diag_plan.recv_timestamp,high_controller_diag_plan.plan_velocity_x);
    plot(gps_state.recv_timestamp,gps_state.velocity_x);
    plot(emb_state.recv_timestamp,emb_state.velocity_x);
    xlabel('time (sec)');
    ylabel('velocity (m/s)');
    legend('planned velocity','gps state velocity','emb state velocity');
end
%%%%%%%%%%
if exist('pos_con_telemetry','var')
    velocityy = figure('Name','vely','WindowStyle','docked');
    hold on;
    grid on;
    vel_y_error = pos_con_telemetry.vel_y_con_telem_ref - pos_con_telemetry.vel_y_con_telem_meas;
    
    plot(pos_con_telemetry.recv_timestamp,pos_con_telemetry.vel_y_con_telem_ref);
    plot(gps_state.recv_timestamp,gps_state.velocity_y);
    plot(emb_state.recv_timestamp,emb_state.velocity_y);
    plot(pos_con_telemetry.recv_timestamp,vel_y_error);
    plot(pos_con_telemetry.recv_timestamp,pos_con_telemetry.vel_y_con_telem_output);
        
    xlabel('time (sec)');
    ylabel('velocity (m/s)');
    legend('planned velocity','gps state velocity','emb state velocity','vel error','vel output');
else ~drontype
    velocityy = figure('Name','vely','WindowStyle','docked');
    hold on;
    grid on;
    plot(high_controller_diag_plan.recv_timestamp,high_controller_diag_plan.plan_velocity_y);
    plot(gps_state.recv_timestamp,gps_state.velocity_y);
    plot(emb_state.recv_timestamp,emb_state.velocity_y);
    xlabel('time (sec)');
    ylabel('velocity (m/s)');
    legend('planned velocity','gps state velocity','emb state velocity');
end   
%%%%%%%%%% 
if exist('pos_con_telemetry','var')
    velocityz = figure('Name','velz','WindowStyle','docked');
    hold on;
    grid on;
    vel_z_error = pos_con_telemetry.vel_z_con_telem_ref - pos_con_telemetry.vel_z_con_telem_meas;
    plot(pos_con_telemetry.recv_timestamp,pos_con_telemetry.vel_z_con_telem_ref);
    plot(gps_state.recv_timestamp,gps_state.velocity_z);
    plot(emb_state.recv_timestamp,movingmean(emb_state.velocity_z,1,1,1));
    plot(pos_con_telemetry.recv_timestamp,vel_z_error);
%     plot(pos_con_telemetry.recv_timestamp,pos_con_telemetry.vel_z_con_telem_output);
%     plot(time,veldiff);    
    xlabel('time (sec)');
    ylabel('velocity (m/s)');
    legend('planned velocity','gps state velocity','emb state velocity','vel error'); %,'vel output');
else ~drontype
      velocityz = figure('Name','velz','WindowStyle','docked');
    hold on;
    grid on;
    plot(high_controller_diag_plan.recv_timestamp,high_controller_diag_plan.plan_velocity_z);
    plot(gps_state.recv_timestamp,gps_state.velocity_z);
    plot(emb_state.recv_timestamp,emb_state.velocity_z);
    xlabel('time (sec)');
    ylabel('velocity (m/s)');
    legend('planned velocity','gps state velocity','emb state velocity');
end
    
