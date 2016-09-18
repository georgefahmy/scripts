%% CPU Info
cpu_info = figure('Name','CPU Info','WindowStyle','docked');
 plot(system_monitor.recv_timestamp,system_monitor.mem_usage,...
     system_monitor.recv_timestamp,system_monitor.cpu_usage);
 grid on;
 xlabel('time (sec)');
 ylabel('% usage');
 legend('Memory','CPU');
 title('CPU Info');