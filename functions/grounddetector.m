%% grounddetector
% the ground detector function uses the 4 variables above to check to see
% if the drone landed on the ground or not.
accel = emb_sensor.accel_z;
gyro = sqrt(emb_sensor.gyro_x.^2 + emb_sensor.gyro_y.^2 + emb_sensor.gyro_z.^2);
throttle = emb_command.throttle;
velocity = emb_state.velocity_z;
time = emb_sensor.recv_timestamp;

lengthend = min([length(accel) length(gyro) length(throttle) length(velocity)]);

accel = movingmean(accel(1:lengthend),10);
gyro = movingmean(gyro(1:lengthend),10);
throttle = throttle(1:lengthend);
velocity = velocity(1:lengthend);

fs = round(length(gyro)/(time(end)-time(1))); %sampling frequency
time = [0:1/fs:((length(gyro)-1)/fs)];
gdtimer = 0;
for i = 1:length(time)
    if  gyro(i) > 1.4 && accel(i) < -1.3 && throttle(i) < .6
        gdtimer(i) = time(i);
    end
    
end
gdtime = gdtimer(gdtimer ~= 0);
gdtime = gdtime(1) + 1;
 
figure;
plot(time,[accel gyro throttle velocity]);
grid on;
xlabel('time (sec)');
legend('accel','gyro','throttle','velocity z','Location','best');
vline(gdtime,'r','gd');
