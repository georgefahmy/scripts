%% T-Motor and T-Motor Prop (14.8v 15x5CF Prop)
 
startdir = '/Users/georgeKespry/Documents/Projects/MATLAB/Prop_Data';
prop_file = uigetfile('.txt',startdir);
prop_file = [startdir '/' prop_file];
prop_data = importpropdata(prop_file);


 
 %% Plots
if 1 
    prop_data.time = prop_data.time(1:10:13920);
    prop_data.throttle = prop_data.throttle(1:10:13920);
    prop_data.rpm = prop_data.rpm(1:10:13920);
    prop_data.thrust = prop_data.thrust(1:10:13920);
    prop_data.torque = prop_data.torque(1:10:13920);
    prop_data.current = prop_data.current(1:10:13920);
    prop_data.voltage = prop_data.voltage(1:10:13920);
end
 
 
    
    prop_data.power = prop_data.current.*prop_data.voltage; 
    prop_data.efficiency = (prop_data.thrust*1000)./prop_data.power; 
  
    figure;
    subplot(1,3,1)
    
    scatter(prop_data.rpm,prop_data.efficiency);
    grid on;
    xlabel('rpm');
    ylabel('efficiency (g/w)');
   
   subplot(1,3,2)
  
    scatter(prop_data.thrust(prop_data.efficiency > -5),prop_data.efficiency(prop_data.efficiency > -5));
    grid on;
    xlabel('thrust (g)');
    ylabel('efficiency (g/w)');
    hold on;

    xco2 = polyfit(prop_data.thrust,prop_data.efficiency,7);
    xfit2 = linspace(min(prop_data.thrust), max(prop_data.thrust),847);
    yfit2 = polyval(xco2,xfit2);
    plot(xfit2,yfit2);
    
    subplot(1,3,3)
    
    scatter(prop_data.rpm,prop_data.thrust)
    grid on;
    xlabel('rpm');
    ylabel('thrust (g)');
    hold on;
    
    xco = polyfit(prop_data.rpm,prop_data.thrust,2);
    xfit = linspace(min(prop_data.rpm), max(prop_data.rpm),length(prop_data.rpm));
    yfit = polyval(xco,xfit);
    plot(xfit,yfit);
    
    
    figure;
    scatter(prop_data.throttle,prop_data.rpm);
    grid on;
    xlabel('throttle');
    ylabel('rpm');
    
   