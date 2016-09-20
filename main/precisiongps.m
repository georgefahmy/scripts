%% Precision GPS
% Translation X
precision_x = figure('Name','precision_x','WindowStyle','docked');
hold on;

[prec_time_x, prec_error_x] = interpOp(gps_sbf_state.recv_timestamp,gps_sbf_state.translation_x,...
    gps_state.recv_timestamp,gps_state.translation_x,'-');
        

if exist('gps_sbf_state','var')
    plot(path_target.recv_timestamp,path_target.position_x);
    plot(gps_state.recv_timestamp,gps_state.translation_x);
    plot(gps_sbf_state.recv_timestamp,gps_sbf_state.translation_x);
    plot(prec_time_x,abs(prec_error_x));
    legend('target position','ublox gps','precision gps','precision vs non-precision');
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
    plot(path_target.recv_timestamp,path_target.position_y);
    plot(gps_state.recv_timestamp,gps_state.translation_y);
    plot(gps_sbf_state.recv_timestamp,gps_sbf_state.translation_y);
    plot(prec_time_y,abs(prec_error_y));
    legend('target position','ublox gps','precision gps','precision vs non-precision');
end
  
grid on;
xlabel('time (sec)');
ylabel('position y');

% Translation z

precision_z = figure('Name','precision_y','WindowStyle','docked');
hold on;

[prec_time_z, prec_error_z] = interpOp(gps_sbf_state.recv_timestamp,gps_sbf_state.translation_z,...
    gps_state.recv_timestamp,gps_state.translation_z,'-');
        

if exist('gps_sbf_state','var')
    plot(path_target.recv_timestamp,path_target.position_z);
    plot(gps_state.recv_timestamp,gps_state.translation_z);
    plot(gps_sbf_state.recv_timestamp,gps_sbf_state.translation_z);
    plot(prec_time_z,abs(prec_error_z));
    legend('target position','ublox gps','precision gps','precision vs non-precision');
end
  
grid on;
xlabel('time (sec)');
ylabel('position z');
