%%
%  this script is used to compare accel, position, and velocity. the
%  integral of the accelerometer and derivative of the gps position are
%  compared.
% 

emb_sensor.gyro_time = 0:1/100:((length(emb_sensor.gyro_y)-1)/100);
emb_sensor.accel_time = 0:1/100:((length(emb_sensor.accel_z)-1)/100);

int_accel_x = cumtrapz(emb_sensor.accel_time,detrend(movingmean(emb_sensor.accel_x-mean(emb_sensor.accel_x),1,1,1),'linear',[1:2])*9.8065);
int_accel_y = cumtrapz(emb_sensor.accel_time,detrend(movingmean(emb_sensor.accel_y-mean(emb_sensor.accel_y),1,1,1),'linear',[1:2])*9.8065);
int_accel_z = cumtrapz(emb_sensor.accel_time,detrend(movingmean(emb_sensor.accel_z-mean(emb_sensor.accel_z),1,1,1),'linear',[1:2])*9.8065);

baro_dzdt = movingmean(diff(movingmean(-baro.altitude,25,1,1))/(1/25),25,1,1);

gps_dxdt = diff(gps_state.translation_x)/.2;
gps_dydt = diff(gps_state.translation_y)/.2;
gps_dzdt = diff(gps_state.translation_z)/.2;

figure('WindowStyle','docked');hold on;grid on;
plot(gps_state.recv_timestamp,gps_state.velocity_z,'DisplayName','gps velocity z')
plot(emb_state.recv_timestamp,movingmean(emb_state.velocity_z,1,1,1),'DisplayName','emb velocity z')
plot(emb_sensor.accel_time,movingmean(emb_sensor.accel_z,10,1,1),'DisplayName','emb sensor accel z');
plot(emb_sensor.accel_time,int_accel_z,'DisplayName','integrated accel z');
plot(gps_state.recv_timestamp(1:end-1),gps_dxdt,'DisplayName','gps dz/dt');
plot(baro.recv_timestamp(1:end-1),baro_dzdt,'DisplayName','dbaro/dt');

xlabel('time');
legend('-DynamicLegend','Location','Best');

