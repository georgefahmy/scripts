%% CPU Info
cpu_info = figure('Name','CPU Info','WindowStyle','docked');
 plot(system_monitor.recv_timestamp,system_monitor.mem_usage,...
     system_monitor.recv_timestamp,system_monitor.cpu_usage);
 hold on;
 if ~isempty(system_monitor.swap_usage)
     plot(system_monitor.recv_timestamp,system_monitor.swap_usage);
 end
 grid on;
 xlabel('time (sec)');
 ylabel('% usage');
 legend('Memory','CPU','Swap');
 title('CPU Info');