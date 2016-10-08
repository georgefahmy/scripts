%% RSSI Stuff
if (exist('command_interface_status','var') && ~isnan(mean(command_interface_status.serial_signal_strength(2:end))))
    if exist('command_interface_status','var')
        [time, signal] = interpOp(command_interface_status.recv_timestamp,command_interface_status.serial_signal_strength,emb_state.recv_timestamp,emb_state.translation_x,'');
        x = emb_state.translation_x(1:end-1);
        y = emb_state.translation_y(1:end-1);
        z = -emb_state.translation_z(1:end-1);
        c = -signal(1:end-1);
        
        for i = 1:length(c)
            if c(i) > -40 
                c(i) = -40;
            end
        end
        
        %3d rssi plot
        rssi3d = figure('Name','rssi3d','WindowStyle','docked');
        plot4(y(1:25:end),x(1:25:end),z(1:25:end),c(1:25:end),-120,-40,'o');
        grid on;
        title('RSSI vs Position');
        xlabel('y (m)');
        ylabel('x (m)');
        zlabel('z (m)');
        colormap('jet');
        h = colorbar('ylim',[-120 -40],'Location','eastoutside');
        caxis([-120 -40]);
        set(h,'YTick',-120:10: -40);
        daspect([1 1 1]);
        set(rssi3d,'Clipping','off');
    
        %rssi vs time plot
        rssi_plot = figure('Name','rssi_plot','WindowStyle','docked');
        plot(command_interface_status.recv_timestamp,-command_interface_status.serial_signal_strength);
        grid on;
        xlabel('Time');
        ylabel('RSSI (db)');
        title('RSSI');
        
        dist = sqrt(emb_state.translation_x.^2+emb_state.translation_y.^2);
        dist = dist(1:end);
        
        %rssi vs distance
        rssi_dist = figure('Name','rssi_dist','WindowStyle','docked');
        plot(dist,-signal);
        grid on;
        xlabel('Radial Distance (m)');
        ylabel('RSSI (db)');
        title('RSSI vs Dist'); 
        
        %packets
        packets = figure('Name','packets','WindowStyle','docked');
        plot(command_interface_status.recv_timestamp,command_interface_status.num_packets_received);
        grid on;
        xlabel('time (sec)');
        ylabel('packet count');
        title('packets vs time');
        
        %kbox rssi
        if exist('kbox_health','var')
            kbox_rssi = figure('Name','kbox_rssi','WindowStyle','docked');
            plot(command_interface_status.recv_timestamp,command_interface_status.serial_signal_strength,...
                 kbox_health.time,kbox_health.rssi)
            xlabel('time');
            ylabel('rssi (-db)'); 
        end
    end
end