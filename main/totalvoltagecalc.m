%% total voltage calculator
if ~exist('totalvoltage','var')
    
    totalvoltage = emb_mgmt.bms_voltage;
       
    
elseif exist('totalvoltage','var')
    
    for i = 1:length(emb_mgmt.bms_voltage)
        totalvoltage(end+1) = emb_mgmt.bms_voltage(i);
    end
    
end

%% totalvoltage plot

figure;
hold on;
grid on;
xlabel('time (sec)');
ylabel('volts');
xlim([0 length(totalvoltage) + 20]);
ylim([21 26]);

plot(totalvoltage,'DisplayName','total voltage');
plot(movingmean(totalvoltage,60,1,1),'DisplayName','low passed voltage');
legend('-DynamicLegend');