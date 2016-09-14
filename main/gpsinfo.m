%% GPS info
if exist('gps_ubx_nav_pvt','var') && dronetype
    for i = 1:length(gps_ubx_nav_pvt.recv_timestamp)
        if gps_ubx_nav_pvt.pdop(i) == 9999
            gps_ubx_nav_pvt.pdop(i) = 0;
        end
    end

    gps_info_plot = figure('Name','gps ubx nav pvt','WindowStyle','docked');
    grid on;
    hold on;
    if length(gps_ubx_nav_pvt.num_sv) == 1
        gps_ubx_nav_pvt.num_sv = gps_ubx_nav_pvt.num_sv*ones(length(gps_ubx_nav_pvt.timestamp),1);
    end
    scatter(gps_ubx_nav_pvt.recv_timestamp,gps_ubx_nav_pvt.num_sv,'r');
    legend('satellites'); 
    scatter(gps_ubx_nav_pvt.recv_timestamp,gps_ubx_nav_pvt.pdop,'b','*');
    legend('satellites','pdop'); 
    xlabel('time');
    
    gpsaccuracy = figure('Name','gps accuracy','WindowStyle','docked');
    grid on;
    hold on;
    plot(gps_ubx_nav_pvt.recv_timestamp,gps_ubx_nav_pvt.h_acc/1000,...
         gps_ubx_nav_pvt.recv_timestamp,gps_ubx_nav_pvt.v_acc/1000);
     legend('h acc','v acc');
     xlabel('time (sec)');
     ylabel('accuracy (m)');
    
end

if exist('gps_ubx_nav_pvt','var') && ~dronetype
    for i = 1:length(gps_ubx_nav_pvt.recv_timestamp)
        if gps_ubx_nav_pvt.pDOP(i) == 9999
            gps_ubx_nav_pvt.pDOP(i) = 0;
        end
    end

    gps_info_plot = figure('Name','gps ubx nav pvt','WindowStyle','docked');
    grid on;
    hold on;
    if length(gps_ubx_nav_pvt.numSV) == 1
        gps_ubx_nav_pvt.numSV = gps_ubx_nav_pvt.numSV*ones(length(gps_ubx_nav_pvt.timestamp),1);
    end
    scatter(gps_ubx_nav_pvt.recv_timestamp,gps_ubx_nav_pvt.numSV,'r');
    legend('satellites'); 
    scatter(gps_ubx_nav_pvt.recv_timestamp,gps_ubx_nav_pvt.pDOP,'b','*');
    legend('satellites','pdop'); 
    xlabel('time');
    
    gpsaccuracy = figure('Name','gps accuracy','WindowStyle','docked');
    grid on;
    hold on;
    plot(gps_ubx_nav_pvt.recv_timestamp,gps_ubx_nav_pvt.hAcc,...
         gps_ubx_nav_pvt.recv_timestamp,gps_ubx_nav_pvt.vAcc);
     legend('h acc','v acc');
     xlabel('time (sec)');
     ylabel('accuracy (mm)');
end

