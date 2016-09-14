function grounddetector(emb_sensor,emb_command,emb_state)
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

accel = movingmean(accel,4);
if exist('movvar') == 5
    gyro = movvar(gyro,10,1);
else
    gyro = movingmean(gyro,5);
end

vector_lengths = cellfun(@(x) length(x),{accel gyro throttle velocity});
time = [0:1/100:(min(vector_lengths)-1)/100]';

switch min(vector_lengths)
    case vector_lengths(1)
        c = 1;
        [gtime,gyro] = interpOp(gtime,gyro,atime,accel,'');
        [ttime,throttle] = interpOp(ttime,throttle,atime,accel,'');
        [vtime,velocity] = interpOp(vtime,velocity,atime,accel,'');
        
    case vector_lengths(2)
        c = 2;
        [atime,accel] = interpOp(atime,accel,gtime,gyro,'');
        [ttime,throttle] = interpOp(ttime,throttle,gtime,gyro,'');
        [vtime,velocity] = interpOp(vtime,velocity,gtime,gyro,'');
        
    case vector_lengths(3)
        c = 3;
        [atime,accel] = interpOp(atime,accel,ttime,throttle,'');
        [gtime,gyro] = interpOp(gtime,gyro,ttime,throttle,'');
        [vtime,velocity] = interpOp(vtime,velocity,ttime,throttle,'');

    case vector_lengths(4)
        c = 4;
        [atime,accel] = interpOp(atime,accel,vtime,velocity,'');
        [gtime,gyro] = interpOp(gtime,gyro,vtime,velocity,'');
        [ttime,throttle] = interpOp(ttime,throttle,vtime,velocity,'');
end

%%%%%%%%%%
%throttle/velocity detection
gd = 0;
for i = length(time)-100*100:length(time)
    if abs(velocity(i)) < .2 && throttle(i) < .55
        gd(i) = time(i);
    else
        gd(i) = 0;
    end 
end
gd = gd(gd~=0);
shutoff2 = gd(1); % 10 milisecond wait
%%%%%%%%%%
%bump detector
for i = 1:length(time)
    if gyro(i) > 1.3 && accel(i) < -1.3
        bump(i) = time(i);
        
    else
        bump(i) = 0;
    end
end
bump = bump(bump~=0);
bump = bump(end);

if exist('bump','var') && ~isempty(bump)
    bump_timer = bump;
    timer_end = bump_timer + 3;
    for i = find(time == bump_timer):find(time == timer_end)
        if abs(velocity(i)) < .6 && throttle(i) < .66
            shutoff(i) = time(i);
        else
            shutoff(i) = 0;
        end
    end
    
    shutoff = shutoff(shutoff~=0);
    if ~isempty(shutoff)
        shutoff = shutoff(1);
    end
        
end
if ~exist('shutoff','var') && ~exist('bump_timer','var')
    shutoff = shutoff2;
end
if isempty(shutoff)
    shutoff = shutoff2;
end

%%%%%%%%%%
    
    figure;
    plot(atime,accel,gtime,gyro,ttime,throttle,vtime,velocity);
    grid on;
    xlabel('time (sec)');
    legend('accel','gyro','throttle','velocity z','Location','best');
    if exist('bump_timer','var')
        vline(bump_timer,'g','bump');
    end
    vline([shutoff shutoff2],{'r','b'},{'shutoff','shutoff 2'});
    
end