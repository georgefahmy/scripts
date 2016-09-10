%% flight score plot
figure('Name','flightscore','WindowStyle','docked');
grid on;
hold on;
plot(numb,score.pos_con_score);
plot(numb,score.calculated_score);
%set(gca,'XTick',[0:dev:10*dev]);
ylabel('percentage');
xlabel('std deviation meters');
legend('recorded telemetry errors','calculated gps errors');