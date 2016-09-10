%% bms system
if exist('emb_mgmt','var') && exist('system_monitor','var')
        current_plot = figure('Name','bms_current','WindowStyle','docked');
        plot(abs(emb_mgmt.bms_current));
        grid on;
        xlabel('time');
        ylabel('amps');
        title('bms current');
        legend('battery current');
    
        voltage_plot = figure('Name','bms_voltage','WindowStyle','docked');
        plot(emb_mgmt.bms_voltage);
        grid on;
        xlabel('time');
        ylabel('volts');
        title('bms voltage');
        legend('battery Voltage');
        
        power_plot = figure('Name','bms_power','WindowStyle','docked');
        plot(emb_mgmt.bms_power);
        grid on;
        xlabel('time');
        ylabel('watts');
        title('bms power');
        legend('power');
        
        
    end