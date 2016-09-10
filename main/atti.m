%% Attitude Estimator

% for i = 1:length(emb_state.yaw)
%         if emb_state.yaw(i) < 0
%             emb_state.yaw(i) = pi + (abs(emb_state.yaw(i)));
%         else 
%             emb_state.yaw(i) = emb_state.yaw(i);
%         end
% end

figure('WindowStyle','docked','Name','Attitude');
plot([0:1/100:(length(emb_state.pitch(1:end-1))/100)],...
     [emb_state.pitch*180/pi,...
      emb_state.roll*180/pi,...
      emb_state.yaw*180/pi]) ;  
grid on;
xlabel('Time (sec)');
ylabel('Angle (deg)');
legend('Pitch','Roll','Yaw');

figure('WindowStyle','docked','Name','gyro biases');
plot([0:1/100:(length(emb_estimator.gyro_bias_x(1:end-1))/100)],...
     [emb_estimator.gyro_bias_x,...
      emb_estimator.gyro_bias_y,...
      emb_estimator.gyro_bias_z]) ;  
grid on;
xlabel('Time (sec)');
ylabel('bias (rad/s)');
legend('gyro x','gyro y','gyro z');
