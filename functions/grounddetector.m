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
    posvar = movvar(emb_state.translation_z,100,1);
    ptime = [0:1/100:(length(posvar)-1)/100]';
% elseif exist('var') == 2
%     gyro = var(gyro);
%     posvar = var(emb_state.translation_z);
%     ptime = [0:1/100:(length(posvar)-1)/100]';
else
    gyro = movingmean(gyro,5);
    posvar = movingmean(emb_state.translation_z,100,1);
    ptime = [0:1/100:(length(posvar)-1)/100]';
end

vector_lengths = cellfun(@(x) length(x),{accel gyro throttle velocity});
time = [0:1/100:(min(vector_lengths)-1)/100]';

switch min(vector_lengths)
    case vector_lengths(1)
        c = 1;
        [gtime,gyro] = interpOp(gtime,gyro,atime,accel,'');
        [ttime,throttle] = interpOp(ttime,throttle,atime,accel,'');
        [vtime,velocity] = interpOp(vtime,velocity,atime,accel,'');
        [ptime,posvar] = interpOp(ptime,posvar,atime,accel,'');
        
        
    case vector_lengths(2)
        c = 2;
        [atime,accel] = interpOp(atime,accel,gtime,gyro,'');
        [ttime,throttle] = interpOp(ttime,throttle,gtime,gyro,'');
        [vtime,velocity] = interpOp(vtime,velocity,gtime,gyro,'');
        [ptime,posvar] = interpOp(ptime,posvar,atime,accel,'');
        
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
        [ptime,posvar] = interpOp(ptime,posvar,atime,accel,'');
end

%%%%%%%%%%
%throttle/velocity detection
gd = 0;
for i = find(time == round(time(end)+(min(emb_state.translation_z)*1.1))):find(time == time(end))
    if abs(velocity(i)) < .2 && throttle(i) < .50
        gd(i) = time(i);
    else
        gd(i) = 0;
    end 
end
gd = gd(gd~=0);

if ~isempty(gd)
    shutoff2 = gd(1);
else
    shutoff2 = find(time(end));
end
%%%%%%%%%%
%bump detector
for i = find(time == round(time(end)+(min(emb_state.translation_z)*1.1))):find(time == time(end))
    if gyro(i) > 3
        bump(i) = time(i);
        
    else
        bump(i) = 0;
    end
end
bump = bump(bump~=0);
if ~isempty(bump)
    bump = bump(1);
else
    bump = [];
end
%%%%%%%%%%
%shutoff requirements
if exist('bump','var') && ~isempty(bump)
    bump_timer = bump;
    timer_end = bump_timer + 1;
    for i = find(time == bump_timer):find(time == timer_end)
        if throttle(i) < .62
            shutoff(i) = time(i);
        else
            shutoff(i) = 0;
        end
    end
    
    shutoff = shutoff(shutoff~=0);
    if ~isempty(shutoff)  
        shutoff = shutoff(10);
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
    plot(atime,accel,gtime,gyro,ttime,throttle,vtime,velocity,ptime,posvar);
    grid on;
    xlabel('time (sec)');
    legend('accel','gyro','throttle','velocity z','position variance','Location','best');
    if exist('bump_timer','var')
        vline(bump_timer,'g','bump');
    end
    vline([shutoff shutoff2],{'r','b'},{'shutoff','shutoff 2'});
    
    clear shutoff* bump* gd timer end *time accel gyro throttle velocity posvar