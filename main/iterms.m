%% Iterms

%% veliterms
velitermfig = figure('Name','vel con i terms','WindowStyle','docked');
grid on;
hold on;

if mean(pos_con_telemetry.vel_x_con_telem_iterm) ~= 0
    [time, velxitermki] = interpOp(pos_con_telemetry.recv_timestamp,pos_con_telemetry.vel_x_con_telem_iterm,pos_con_config.recv_timestamp,pos_con_config.vel_xy_ki,'*');
    
    plot(time,velxitermki,'DisplayName','vel x iterm * ki');
end
if mean(pos_con_telemetry.vel_y_con_telem_iterm) ~= 0
   [time, velyitermki] = interpOp(pos_con_telemetry.recv_timestamp,pos_con_telemetry.vel_y_con_telem_iterm,pos_con_config.recv_timestamp,pos_con_config.vel_xy_ki,'*');
    
    plot(time,velyitermki,'DisplayName','vel y iterm * ki');
end
if mean(pos_con_telemetry.vel_z_con_telem_iterm) ~= 0
   [time, velzitermki] = interpOp(pos_con_telemetry.recv_timestamp,pos_con_telemetry.vel_z_con_telem_iterm,pos_con_config.recv_timestamp,pos_con_config.vel_z_ki,'*');
    
    plot(time,velzitermki,'DisplayName','vel z iterm * ki');
end
xlabel('time');
ylabel('i term command ');
l = legend('-DynamicLegend','Location','Best');
if isempty(l)
    close(gcf)
end

%% pos iterms
positermfig = figure('Name','pos con i terms','WindowStyle','docked');
grid on;
hold on;
if mean(pos_con_telemetry.pos_x_con_telem_iterm) ~= 0
    [time, xitermki] = interpOp(pos_con_telemetry.recv_timestamp,pos_con_telemetry.pos_x_con_telem_iterm,pos_con_config.recv_timestamp,pos_con_config.pos_xy_ki,'*');
    
    plot(time,xitermki,'DisplayName','pos x iterm * ki');
end
if mean(pos_con_telemetry.pos_y_con_telem_iterm) ~= 0
    [time, yitermki] = interpOp(pos_con_telemetry.recv_timestamp,pos_con_telemetry.pos_y_con_telem_iterm,pos_con_config.recv_timestamp,pos_con_config.pos_xy_ki,'*');
    
    plot(time,yitermki,'DisplayName','pos y iterm * ki');
end
if mean(pos_con_telemetry.pos_z_con_telem_iterm) ~= 0
   [time, zitermki] = interpOp(pos_con_telemetry.recv_timestamp,pos_con_telemetry.pos_z_con_telem_iterm,pos_con_config.recv_timestamp,pos_con_config.pos_z_ki,'*');
    
    plot(time,zitermki,'DisplayName','pos z iterm * ki');
end

xlabel('time');
ylabel('i term command ');
h = legend('-DynamicLegend','Location','Best');
if isempty(h)
    close(gcf)
end

%% att rate con iterms
figure('Name','att rate con iterms','WindowStyle','docked');
grid on;
hold on;
plot(att_rate_con_telem.recv_timestamp,att_rate_con_telem.pid_telem_r_iterm*0.015);
plot(att_rate_con_telem.recv_timestamp,att_rate_con_telem.pid_telem_p_iterm*0.015);
plot(att_rate_con_telem.recv_timestamp,att_rate_con_telem.pid_telem_y_iterm*0.01);
legend('roll rate * ki','pitch rate * ki','yaw rate * ki');
xlabel('time');
ylabel('delta throttle');

%att rate con d terms
figure('Name','att rate con d terms','WindowStyle','docked');
grid on;
hold on;
plot(att_rate_con_telem.recv_timestamp,att_rate_con_telem.pid_telem_r_d_error * 0.0016);
plot(att_rate_con_telem.recv_timestamp,att_rate_con_telem.pid_telem_p_d_error * 0.0016);
%plot(att_rate_con_telem.recv_timestamp,att_rate_con_telem.pid_telem_y_d_error * 0.0016/.01);
legend('roll rate * kd','pitch rate * kd');
xlabel('time');
ylabel('delta throttle');

%%
% integratedvelx = cumtrapz(gps_state.recv_timestamp,gps_state.velocity_x);
% integratedvely = cumtrapz(gps_state.recv_timestamp,gps_state.velocity_y);
% integratedvelz = cumtrapz(gps_state.recv_timestamp,gps_state.velocity_z);
% 
% figure('Name','integrated velocities','WindowStyle','docked');
% hold on;
% grid on;
% plot(emb_state.recv_timestamp,emb_state.translation_x,gps_state.recv_timestamp,integratedvelx)
% plot(emb_state.recv_timestamp,emb_state.translation_y,gps_state.recv_timestamp,integratedvely)
% plot(emb_state.recv_timestamp,emb_state.translation_z,gps_state.recv_timestamp,integratedvelz)
% legend('emb state.x','integrated.x','emb state.y','integrated.y','emb state.z','integrated.z');

%% d terms
if mean(pos_con_telemetry.pos_z_con_telem_d_error) ~= 0
figure('Name','position d terms','WindowStyle','docked');
hold on;
grid on;
plot(pos_con_telemetry.recv_timestamp,pos_con_telemetry.pos_x_con_telem_d_error);
plot(pos_con_telemetry.recv_timestamp,pos_con_telemetry.pos_y_con_telem_d_error);
plot(pos_con_telemetry.recv_timestamp,pos_con_telemetry.pos_z_con_telem_d_error*0.01);
xlabel('time')
ylabel('d error');
legend('pos x d term','pos y d term','pos z d term');
end

if mean(pos_con_telemetry.vel_x_con_telem_d_error) ~= 0
figure('Name','velocity d terms','WindowStyle','docked');
hold on;
grid on;
plot(pos_con_telemetry.recv_timestamp,pos_con_telemetry.vel_x_con_telem_d_error);
plot(pos_con_telemetry.recv_timestamp,pos_con_telemetry.vel_y_con_telem_d_error);
plot(pos_con_telemetry.recv_timestamp,pos_con_telemetry.vel_z_con_telem_d_error);
xlabel('time')
ylabel('d error');
legend('vel x d term','vel y d term','vel z d term');
end
