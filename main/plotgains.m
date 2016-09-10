%% gains plot
if exist('gains','var')
    figure('Name','gains','WindowStyle','docked');
    hold on;
    grid on;
    xlabel('time');
    ylabel('gain value');
    
    plot(gains.pos_xy_kp,'Marker','o');
    plot(gains.pos_xy_ki,'Marker','o');
    plot(gains.pos_xy_kd,'Marker','o');

    plot(gains.pos_z_kp,'Marker','o');
    plot(gains.pos_z_ki,'Marker','o');
    plot(gains.pos_z_kd,'Marker','o');

    plot(gains.vel_xy_kp,'Marker','x');
    plot(gains.vel_xy_ki,'Marker','x');
    plot(gains.vel_xy_kd,'Marker','x');

    plot(gains.vel_z_kp,'Marker','x');
    plot(gains.vel_z_ki,'Marker','x');
    plot(gains.vel_z_kd,'Marker','x');
    
    legend('pos xy kp','pos xy ki','pos xy kd',...
           'pos z kp','pos z ki','pos z kd',...
           'vel xy kp','vel xy ki','vel xy kd',...
           'vel z kp','vel z ki','vel z kd');
        
        
end

