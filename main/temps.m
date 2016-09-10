%% temperatures
if exist('system_monitor') && ~isempty(system_monitor.recv_timestamp) 
    
        magtime = [1:length(emb_sensor.mag_temp)];
        magtime = magtime+system_monitor.recv_timestamp(1);
            
        temp = figure('Name','temps','WindowStyle','docked');
        plot([1:length(emb_sensor.MAXypprr_temp)],emb_sensor.MAXypprr_temp,system_monitor.recv_timestamp,...
             system_monitor.MCU_temp,system_monitor.recv_timestamp,system_monitor.core_temp,...
             magtime,emb_sensor.mag_temp);
        hold on;
        if exist('baro','var') && mean(baro.temp_C) ~= 0
        plot(baro.recv_timestamp,baro.temp_C);
        end
        grid on;
        xlabel('time');
        ylabel('temp (c)');
        title('temperatures');
        legend('imu temp','mcu temp','core temp','mag temp','baro temp');
    end