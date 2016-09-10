function temp = tempcalc(baro, gps_state,meta)

%
% altitude is the gps altitude average before the flight take off
% pressure is the baro pressure averaged before flight take off
% meta is used to get the altitude offset from ground to sealevel
%
%


if length(baro.press_hPa) > 1
    baro.mean_press_hPa = mean(baro.press_hPa(1:200));
end
if length(gps_state.translation_z) > 1
    gps_state.mean_translation_z = mean(-gps_state.translation_z(1:50))+ meta.act_alt;
end

p = baro.press_hPa;
pmean = mean(baro.press_hPa(1:200));
p0 = 1013.25; %static pressure at sea level
L = 0.0065;   %lapse rate
R = 287.053;  %gas constant
g = 9.80665;  %gravity constant
T = 288.15;   %standard temperature at sea level

altitude1 = (-R*T/g)*log(p/pmean);


