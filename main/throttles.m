%% Throttles
if exist('emb_controller','var') && ~isempty(emb_controller.timestamp)
    if length(emb_controller.timestamp) ~= length(emb_controller.throttle_w)
        emb_controller.timestamp = emb_controller.timestamp(1:2:end-1);
    end
    
        throttle_filtval = 1;
        throttle_plot = figure('Name','throttle','WindowStyle','docked');
        hold on;
        plot(emb_controller.recv_timestamp,movingmean(emb_controller.throttle_w,throttle_filtval,1,2)*100); %FL
        plot(emb_controller.recv_timestamp,movingmean(emb_controller.throttle_x,throttle_filtval,1,2)*100); %FR
        plot(emb_controller.recv_timestamp,movingmean(emb_controller.throttle_y,throttle_filtval,1,2)*100); %RR
        plot(emb_controller.recv_timestamp,movingmean(emb_controller.throttle_z,throttle_filtval,1,2)*100); %RL
        plot(emb_command.recv_timestamp,emb_command.throttle*100)
        grid on;
        ylabel('Throttle');
        legend('Front Left','Right Front','Right Rear','Left Rear','command');
        title('Motor Throttle Commands');

    end