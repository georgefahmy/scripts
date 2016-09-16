%% Throttles
if exist('emb_controller','var') && exist('emb_command','var') && ~isempty(emb_controller.recv_timestamp)
    
    vector_lengths = cellfun(@(x) length(x),{emb_command.throttle emb_controller.throttle_x});
    time1 = [0:1/100:(min(vector_lengths)-1)/100]';
    
    if vector_lengths(1) ~= vector_lengths(2)
        switch min(vector_lengths)
            case vector_lengths(1)
                [~,emb_controller.throttle_x] = interpOp(emb_controller.recv_timestamp,emb_controller.throttle_x,emb_command.recv_timestamp,emb_command.throttle,'');
                [~,emb_controller.throttle_y] = interpOp(emb_controller.recv_timestamp,emb_controller.throttle_y,emb_command.recv_timestamp,emb_command.throttle,'');
                [~,emb_controller.throttle_z] = interpOp(emb_controller.recv_timestamp,emb_controller.throttle_z,emb_command.recv_timestamp,emb_command.throttle,'');
                [~,emb_controller.throttle_w] = interpOp(emb_controller.recv_timestamp,emb_controller.throttle_w,emb_command.recv_timestamp,emb_command.throttle,'');
            case vector_lengths(2)
                [~,emb_command.throttle] = interpOp(emb_command.recv_timestamp,emb_command.throttle,emb_controller.recv_timestamp,emb_controller.throttle_x,'');
        end
    end
    
        throttle_filtval = 1;
        throttle_plot = figure('Name','throttle','WindowStyle','docked');
        hold on;
        plot(time1,movingmean(emb_controller.throttle_w,throttle_filtval,1,2)*100); %FL
        plot(time1,movingmean(emb_controller.throttle_x,throttle_filtval,1,2)*100); %FR
        plot(time1,movingmean(emb_controller.throttle_y,throttle_filtval,1,2)*100); %RR
        plot(time1,movingmean(emb_controller.throttle_z,throttle_filtval,1,2)*100); %RL
        plot(time1,emb_command.throttle*100)
        grid on;
        ylabel('Throttle');
        legend('Front Left','Right Front','Right Rear','Left Rear','command');
        title('Motor Throttle Commands');


end