%% Precision GPS
% Translation X
precision_x = figure('Name','precision_x','WindowStyle','docked');
hold on;

[prec_time_x, prec_error_x] = interpOp(gps_sbf_state.recv_timestamp,gps_sbf_state.translation_x,...
    gps_state.recv_timestamp,gps_state.translation_x,'-');
        

if exist('gps_sbf_state','var')
%     plot(path_target.recv_timestamp,path_target.position_x,'DisplayName','target position');
%     plot(gps_state.recv_timestamp,gps_state.translation_x,'DisplayName','ublox gps');
%     plot(gps_sbf_state.recv_timestamp,gps_sbf_state.translation_x,'DisplayName','precision gps');
    plot(prec_time_x,abs(prec_error_x),'DisplayName','precision vs non-precision');
    legend('-DynamicLegend','Location','best');
end
  
grid on;
xlabel('time (sec)');
ylabel('position x');

% Translation Y

precision_y = figure('Name','precision_y','WindowStyle','docked');
hold on;

[prec_time_y, prec_error_y] = interpOp(gps_sbf_state.recv_timestamp,gps_sbf_state.translation_y,...
    gps_state.recv_timestamp,gps_state.translation_y,'-');
        

if exist('gps_sbf_state','var')
%     plot(path_target.recv_timestamp,path_target.position_y,'DisplayName','target position');
%     plot(gps_state.recv_timestamp,gps_state.translation_y,'DisplayName','ublox gps');
%     plot(gps_sbf_state.recv_timestamp,gps_sbf_state.translation_y,'DisplayName','precision gps');
    plot(prec_time_y,abs(prec_error_y),'DisplayName','precision vs non-precision');
    legend('-DynamicLegend','Location','best');
end
  
grid on;
xlabel('time (sec)');
ylabel('position y');

% Translation z

precision_z = figure('Name','precision_z','WindowStyle','docked');
hold on;

[prec_time_z, prec_error_z] = interpOp(gps_sbf_state.recv_timestamp,gps_sbf_state.translation_z,...
    gps_state.recv_timestamp,gps_state.translation_z,'-');
        

if exist('gps_sbf_state','var')
%     plot(path_target.recv_timestamp,path_target.position_z,'DisplayName','target position');
%     plot(gps_state.recv_timestamp,gps_state.translation_z,'DisplayName','ublox gps');
%     plot(gps_sbf_state.recv_timestamp,gps_sbf_state.translation_z,'DisplayName','precision gps');
    plot(prec_time_z,abs(prec_error_z),'DisplayName','precision vs non-precision');
    legend('-DynamicLegend','Location','best');
end
  
grid on;
xlabel('time (sec)');
ylabel('position z');

%%

path3d = figure('Name','3d_precision_gps','WindowStyle','docked');
hold on;        

plot3(gps_state.translation_y,...
      gps_state.translation_x,...
      -gps_state.translation_z);
  
plot3(gps_sbf_state.translation_y,...
      gps_sbf_state.translation_x,...
      -gps_sbf_state.translation_z);

grid on;
xlabel('translation y');
ylabel('translation x');
zlabel('altitude');