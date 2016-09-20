%% Baro vs gps_state
%The temp_diff calculation is the difference between the measured
%barotemp before take-off and the ambient temperature. if set to 0
%then the temp diff does not account for incorrect scaling, which
%is how the current x86 is using the baro.
%The con_factor is the conversion factor after taking into account
%ambient temperature, and then converting the temperature scaling
%based on 8.322...at 15 degrees celcius. that is the reason for
%subtracting 15c off from the sensor_data.barotemp. by adding the
%temp difference and multiplying by the scaling factor of 0.03 we
%can get the conversion factor as a function of temperature to
%convert from hectopascals to meters by adding 8.322...this is what
%results in the altitude calculation. The altitude calculation
%takes into account the average starting pressure to "zero" out the
%sensor, this determines the starting altitude. The meta_data.z_alt
%takes into account the relative home location altitude.

if exist('baro','var')

    %The ambient temp is the measured ambient temperature measured
    %during the time of take-off and is just an approximation.
    %Setting up the vectors, and adjusted for incorrect barometer
    %measurement
    %amb_temp2 = 17;
    Fs = length(baro.press_hPa)/(baro.recv_timestamp(end)-baro.recv_timestamp(1)); %sampling frequency
    Fs = round(Fs);
    
    if length(baro.press_hPa) > 1
    
        amb_temp = min(baro.temp_C);
    
    if amb_temp == 0
        temp_diff = 0;
    else
        temp_diff = amb_temp - mean(baro.temp_C(1:125));
        
    end
    
    temp_diff2 = -15;
    con_factor = (((baro.temp_C)+temp_diff)*0.03) + 7.88801728927; %this takes into account the temperature.
    con_factor2 = (((baro.temp_C)+temp_diff2)*0.03) + 7.88801728927; %this results in the same conversion factor as above but const -15C offset
    baro.altitude = (((baro.press_hPa) - mean(baro.press_hPa(1:200)))*-1).*con_factor;
    baro.altitude2 = (((baro.press_hPa) - mean(baro.press_hPa(1:200)))*-1).*con_factor2;
    baro.amb_temp = amb_temp;
    
    %%%%%%%%%%%%%
        p = baro.press_hPa;
        p0 = mean(baro.press_hPa(1:125));
        R = 287.053;  %gas constant
        g = 9.80665;  %gravity constant
        T0 = 288.15;  %standard temperature at sea level
        z_alt = (-R*T0/g)*log(p/p0); % i like this equation
    %%%%%%%%%%%%%
    
    baro_altitude = movingmean(baro.altitude,1)-meta.z_alt;
    baro_altitude2 = movingmean(baro.altitude2,1)-meta.z_alt;
    no_temp_alt = movingmean(z_alt,1)-meta.z_alt; % this is my favorite
    
        
    baro_plot = figure('Name','baro vs gps state','WindowStyle','docked');
    hold on;
    xlabel('time (sec)');
    ylabel('altitude (m)');
    title('Baro vs gps state');
    plot(baro.recv_timestamp,baro_altitude,'DisplayName','min baro ambient temp');
    plot(baro.recv_timestamp,baro_altitude2,'DisplayName','15C offset');
    plot(baro.recv_timestamp,no_temp_alt,'DisplayName','15C constant');
    plot(gps_state.recv_timestamp,-gps_state.translation_z,'DisplayName','gps state z');
%     plot(emb_state.recv_timestamp,-emb_state.translation_z),'DisplayName','emb state z';
    if exist('sensor_x86','var') && max(abs(sensor_x86.pos_z)) < 300
        plot(sensor_x86.recv_timestamp,-sensor_x86.pos_z,'DisplayName','x86 pos z');
    end
    if exist('gps_sbf_state','var')
        plot(gps_sbf_state.recv_timestamp,-gps_sbf_state.translation_z,'DisplayName','Precision gps');
    end
    legend('-DynamicLegend','Location','best');
    grid on;
    hold off;
    end
 %%   
    if 1
    baro_dzdt = movingmean(diff(movingmean(-baro.altitude,50))*Fs,50);
    gps_dzdt  = movingmean(diff(movingmean(gps_state.translation_z,5))*5,5);
    
    figure('Name','baro velocity','WindowStyle','docked')
    hold on;
    grid on;
    xlabel('time (sec)');
    ylabel('speed (m/s)');
    title('baro velocity vs gps velocity')
    plot(baro.recv_timestamp(1:end-1),baro_dzdt,'DisplayName','baro velocity');
    plot(gps_state.recv_timestamp,gps_state.velocity_z,'DisplayName','gps velocity');
    plot(gps_state.recv_timestamp(1:end-1),gps_dzdt,'DisplayName','gps dzdt');
    legend('-DynamicLegend','Location','Best')
    end
end

