%% Magnetometer plots
    mags = figure('Name','mag','WindowStyle','docked');
    
    magtime1 = [0:1/50:(length(emb_sensor.mag_x)-1)/50];
    magtime2 = [0:1/100:(length(emb_sensor.mag_corrected_x)-1)/100];
    
    hold on;
    grid on;
    plot(magtime1,emb_sensor.mag_x);
    plot(magtime1,emb_sensor.mag_y);
    plot(magtime1,emb_sensor.mag_z);
    plot(magtime2,emb_sensor.mag_corrected_x)
    plot(magtime2,emb_sensor.mag_corrected_y)
    plot(magtime2,emb_sensor.mag_corrected_z)
    legend('mag x','mag y','mag z','corrected x','corrected y','corrected z');