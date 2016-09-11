%% grounddetector
% the ground detector function uses the 4 variables above to check to see
% if the drone landed on the ground or not.
accel = emb_sensor.accel_z;
atime = [0:1/100:(length(accel)-1)/100]';
gyro = sqrt(emb_sensor.gyro_x.^2 + emb_sensor.gyro_y.^2 + emb_sensor.gyro_z.^2);
gtime = [0:1/100:(length(gyro)-1)/100]';
throttle = emb_command.throttle;
ttime = [0:1/100:(length(throttle)-1)/100]';
velocity = emb_state.velocity_z;
vtime = [0:1/100:(length(velocity)-1)/100]';

accel = movingmean(accel,10);
gyro = movingmean(gyro,10);

vector_lengths = cellfun(@(x) length(x),{accel gyro throttle velocity});
time = [0:1/100:(min(vector_lengths)-1)/100]';

switch min(vector_lengths)
    case vector_lengths(1)
        [gtime,gyro] = interpOp(gtime,gyro,atime,accel,'');
        [ttime,throttle] = interpOp(ttime,throttle,atime,accel,'');
        [vtime,velocity] = interpOp(vtime,velocity,atime,accel,'');
        
    case vector_lengths(2)
        [atime,accel] = interpOp(atime,accel,gtime,gyro,'');
        [ttime,throttle] = interpOp(ttime,throttle,gtime,gyro,'');
        [vtime,velocity] = interpOp(vtime,velocity,gtime,gyro,'');
        
    case vector_lengths(3)
        [atime,accel] = interpOp(atime,accel,ttime,throttle,'');
        [gtime,gyro] = interpOp(gtime,gyro,ttime,throttle,'');
        [vtime,velocity] = interpOp(vtime,velocity,ttime,throttle,'');

    case vector_lengths(4)
        [atime,accel] = interpOp(atime,accel,vtime,velocity,'');
        [gtime,gyro] = interpOp(gtime,gyro,vtime,velocity,'');
        [ttime,throttle] = interpOp(ttime,throttle,vtime,velocity,'');
end

gdtimer = 0;
for i = 1:length(time)
    if  gyro(i) > 1.4 && accel(i) < -1.3 && throttle(i) < .55
        gdtimer(i) = time(i);
    end
        
end

gdtime = gdtimer(gdtimer ~= 0);
if isempty(gdtime)
    fprintf('ground detector empty\n')
else
    gdtime = gdtime(1);

    figure;
    plot(atime,accel,gtime,gyro,ttime,throttle,vtime,velocity);
    grid on;
    xlabel('time (sec)');
    legend('accel','gyro','throttle','velocity z','Location','best');
    vline(gdtime,'r','gd');
end
