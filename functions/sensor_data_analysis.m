function [emb_sensor] = sensor_data_analysis(emb_sensor)

emb_sensor.avg_gyrox = mean(emb_sensor.gyro_x);
emb_sensor.avg_gyroy = mean(emb_sensor.gyro_y);
emb_sensor.avg_gyroz = mean(emb_sensor.gyro_z);

emb_sensor.total_g = sqrt(emb_sensor.accel_x.^2 + emb_sensor.accel_y.^2 + emb_sensor.accel_z.^2);

emb_sensor.pitch = movingmean(real(asind(emb_sensor.accel_x)),100,1,2); %negative is pitch down
emb_sensor.roll = movingmean(real(asind(emb_sensor.accel_y)),100,1,2); % negative is right roll
%[sensor_data.magtime, sensor_data.magtemp] = interpOp(sensor_data.time(1:353:end),sensor_data.magtemp,sensor_data.time,sensor_data.timecheck,'');
