x0 = [pxdata.ATT_PitchRate(1) 0]';
y0 = [pxdata.ATT_PitchRate(1); 0; pxdata.u(1)];
x = zeros(2,length(pxdata.time));
x(:,1) = x0;
y = y0;

A = 1;
B = 500;

for i = 1:length(pxdata.time)-1
 tspan = [pxdata.time(i) pxdata.time(i+1)];
 
    [t,ynext] = ode45(@(t,y) plantmodel(t,y,A,B),tspan,y);
    
    y = [ynext(end,1:2), pxdata.u(i+1)]';
    
    x(:,i+1) = ynext(end,1:2)';%-(ynext(end-1,1:2));
    
end

figure('Name','Simulated Data','WindowStyle','docked');
plot(x(1,:));
hold on;
%plot(pxdata.u(3400:5000)/100);
grid on;
plot(movingmean(pxdata.ATT_PitchRate,1,1,2));
%plot(pxdata.prerror);
legend('simulated data','pitch rate','pitch rate error');


