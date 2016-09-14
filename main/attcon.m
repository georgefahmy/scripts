%% Set the filtval to filter the data

if ~exist('att_con_telem_filter_val','var')
    att_con_telem_filter_val = 1;
    att_rate_con_telem_filter_val = 1; 
end
    

%% Angle 
if exist('att_con_telem','var')
pitchangle = figure('Name','pitch angle','WindowStyle','docked');
title('Pitch Angle');
grid on;
hold on;
xlabel('time (sec)');
ylabel('Radians');
plot(att_con_telem.recv_timestamp,(movingmean(att_con_telem.pid_telem_p_ref,att_con_telem_filter_val)));
plot(att_con_telem.recv_timestamp,(movingmean(att_con_telem.pid_telem_p_meas,att_con_telem_filter_val)));
plot(att_con_telem.recv_timestamp,(movingmean(att_con_telem.pid_telem_p_ref-att_con_telem.pid_telem_p_meas,att_con_telem_filter_val)));
%plot(att_con_telem.recv_timestamp,(movingmean(att_con_telem.pid_telem_p_output,att_con_telem_filter_val)));
legend('reference','measured','error')%,'output (deg/s)');

rollangle = figure('Name','roll angle','WindowStyle','docked');
title('Roll Angle');
grid on;
hold on;
xlabel('time (sec)');
ylabel('Radians');
plot(att_con_telem.recv_timestamp,(movingmean(att_con_telem.pid_telem_r_ref,att_con_telem_filter_val)));
plot(att_con_telem.recv_timestamp,(movingmean(att_con_telem.pid_telem_r_meas,att_con_telem_filter_val)));
plot(att_con_telem.recv_timestamp,(movingmean(att_con_telem.pid_telem_r_ref-att_con_telem.pid_telem_r_meas,att_con_telem_filter_val)));
%plot(att_con_telem.recv_timestamp,(movingmean(att_con_telem.pid_telem_r_output,att_con_telem_filter_val)));
legend('reference','measured','error')%,'output (deg/s)');

for i = 1:length(att_con_telem.pid_telem_y_meas)
        if att_con_telem.pid_telem_y_meas(i) < 0
            att_con_telem.pid_telem_y_meas2(i) = 2*pi+(att_con_telem.pid_telem_y_meas(i));
        else 
            att_con_telem.pid_telem_y_meas2(i) = att_con_telem.pid_telem_y_meas(i);
        end
        if att_con_telem.pid_telem_y_ref(i) < 0
            att_con_telem.pid_telem_y_ref2(i) = 2*pi+(att_con_telem.pid_telem_y_ref(i));
        else 
            att_con_telem.pid_telem_y_ref2(i) = att_con_telem.pid_telem_y_ref(i);
        end
end


yawangle = figure('Name','yaw angle','WindowStyle','docked');
title('Yaw Angle');
grid on;
hold on;
xlabel('time (sec)');
ylabel('Radians');
plot(att_con_telem.recv_timestamp,(movingmean(att_con_telem.pid_telem_y_ref,att_con_telem_filter_val)));
plot(att_con_telem.recv_timestamp,(movingmean(att_con_telem.pid_telem_y_meas,att_con_telem_filter_val)));
plot(att_con_telem.recv_timestamp,(movingmean(att_con_telem.pid_telem_y_ref-att_con_telem.pid_telem_y_meas,att_con_telem_filter_val)));
%plot(att_con_telem.recv_timestamp,rad2deg(movingmean(att_con_telem.pid_telem_y_output,att_con_telem_filter_val)));
legend('reference','measured','error')%,'output (deg/s)');
end

%% Rates
if exist('att_rate_con_telem','var')
pitchrate = figure('Name','pitch rate','WindowStyle','docked');
title('Pitch Rate');
grid on;
hold on;
xlabel('time (sec)');
ylabel('Rad/s');
plot(att_rate_con_telem.recv_timestamp,(movingmean(att_rate_con_telem.pid_telem_p_ref,att_rate_con_telem_filter_val)));
plot(att_rate_con_telem.recv_timestamp,(movingmean(att_rate_con_telem.pid_telem_p_meas,att_rate_con_telem_filter_val)));
plot(att_rate_con_telem.recv_timestamp,(movingmean(att_rate_con_telem.pid_telem_p_ref-att_rate_con_telem.pid_telem_p_meas,att_rate_con_telem_filter_val)));
plot(att_rate_con_telem.recv_timestamp,10*(movingmean(att_rate_con_telem.pid_telem_p_output,att_rate_con_telem_filter_val)));
legend('reference','measured','error','output');

rollrate = figure('Name','roll rate','WindowStyle','docked');
title('Roll Rate');
grid on;
hold on;
xlabel('time (sec)');
ylabel('Rad/s');
plot(att_rate_con_telem.recv_timestamp,(movingmean(att_rate_con_telem.pid_telem_r_ref,att_rate_con_telem_filter_val)));
plot(att_rate_con_telem.recv_timestamp,(movingmean(att_rate_con_telem.pid_telem_r_meas,att_rate_con_telem_filter_val)));
plot(att_rate_con_telem.recv_timestamp,(movingmean(att_rate_con_telem.pid_telem_r_ref-att_rate_con_telem.pid_telem_r_meas,att_rate_con_telem_filter_val)));
plot(att_rate_con_telem.recv_timestamp,10*(movingmean(att_rate_con_telem.pid_telem_r_output,att_rate_con_telem_filter_val)));
legend('reference','measured','error','output');

yawrate = figure('Name','Yaw rate','WindowStyle','docked');
title('Yaw Rate');
grid on;
hold on;
xlabel('time (sec)');
ylabel('Rad/s');
plot(att_rate_con_telem.recv_timestamp,(movingmean(att_rate_con_telem.pid_telem_y_ref,att_rate_con_telem_filter_val)));
plot(att_rate_con_telem.recv_timestamp,(movingmean(att_rate_con_telem.pid_telem_y_meas,att_rate_con_telem_filter_val)));
plot(att_rate_con_telem.recv_timestamp,(movingmean(att_rate_con_telem.pid_telem_y_ref-att_rate_con_telem.pid_telem_y_meas,att_rate_con_telem_filter_val)));
plot(att_rate_con_telem.recv_timestamp,10*(movingmean(att_rate_con_telem.pid_telem_y_output,att_rate_con_telem_filter_val)));
legend('reference','measured','error','output');
end


