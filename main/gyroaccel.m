%% gyro and accel
fsa = round(length(emb_sensor.accel_x)/(emb_sensor.recv_timestamp(end)-emb_sensor.recv_timestamp(1))); %sampling frequency
fsg = round(length(emb_sensor.gyro_x)/(emb_sensor.recv_timestamp(end)-emb_sensor.recv_timestamp(1))); %sampling frequency
emb_sensor.gyro_time = [0:1/fsg:((length(emb_sensor.gyro_y)-1)/fsg)];
emb_sensor.accel_time = [0:1/fsa:((length(emb_sensor.accel_x)-1)/fsa)];

if ~exist('gyro_filter_val','var')
    gyro_filter_val = 1;
end

gyro_plot = figure('Name','gyros','WindowStyle','docked');
hold on;
grid on;
plot(emb_sensor.gyro_time,movingmean(emb_sensor.gyro_x,gyro_filter_val,1,1)); % roll
plot(emb_sensor.gyro_time,movingmean(emb_sensor.gyro_y,gyro_filter_val,1,1)); % pitch
plot(emb_sensor.gyro_time,movingmean(emb_sensor.gyro_z,gyro_filter_val,1,1)); % yaw
xlabel('Time (sec)');
ylabel('Angular Rate (rad/s)');
title('Gyro Data');
legend('Roll','Pitch','Yaw');

%accelerometer data plot
accel_plot = figure('Name','accel','WindowStyle','docked');
hold on;
grid on;
plot(emb_sensor.accel_time,movingmean(emb_sensor.accel_x,gyro_filter_val,1,1));
plot(emb_sensor.accel_time,movingmean(emb_sensor.accel_y,gyro_filter_val,1,1));
plot(emb_sensor.accel_time,movingmean(emb_sensor.accel_z,gyro_filter_val,1,1));
plot(emb_sensor.accel_time,movingmean(emb_sensor.total_g,gyro_filter_val,1,1));
xlabel('Time (sec)');
ylabel('g');
title('Accelerometer Data');
legend('Accel X','Accel Y','Accel Z');

%%
% 
% [time, gyromagdiff] = interpOp([0:1/100:((length(emb_sensor.gyro_y)-2)/100)], diff(movingmean(emb_sensor.gyro_y,1,1,1)),...
%                                [0:1/50:(length(emb_sensor.mag_x)-2)/50], diff(emb_sensor.mag_y),'-');
% figure;
% plot(time,gyromagdiff);
% grid on;
%                            
                           
                           