%% Flightscore

if ~exist('done','var')
    done = 0;
end
if done ~= 16
        start_timestamp = min(emb_state.recv_timestamp(emb_state.translation_z < min(emb_state.translation_z) + 1));
        end_timestamp = max(emb_state.recv_timestamp(emb_state.translation_z < min(emb_state.translation_z) + 6));
        flight_time = (end_timestamp-start_timestamp); %flight recv_timestamp in minutes
    if exist('emb_command','var') && exist('emb_state','var')
        takeoff_timestamp = min(emb_state.recv_timestamp(emb_command.throttle > 0));
        landing_timestamp = max(emb_state.recv_timestamp(emb_command.throttle > 0));

        totaltime = landing_timestamp;
    end    
        % Distance Calculation
        if exist('path_target','var')
        plan_x = path_target.position_x;
        plan_y = path_target.position_y;
        plan_z = path_target.position_z;
        else
        plan_x = high_controller_diag_plan.plan_translation_x;
        plan_y = high_controller_diag_plan.plan_translation_y;
        plan_z = high_controller_diag_plan.plan_translation_z;
        end
        act_x = emb_state.translation_x;
        act_y = emb_state.translation_y;
        act_z = emb_state.translation_z;

        plandistance = sum(sqrt(diff(plan_x).^2+diff(plan_y).^2+diff(plan_z).^2));
        actualdistance = sum(sqrt(diff(act_x).^2+diff(act_y).^2+diff(act_z).^2));

        diffdistance = abs(actualdistance-plandistance); %this is the distance error.

        %recv_timestamp definitions for the error calculations
        if exist('path_target','var')
        time1 = path_target.recv_timestamp-path_target.recv_timestamp(1);
        else
        time1 = high_controller_diag_plan.recv_timestamp - high_controller_diag_plan.recv_timestamp(1);
        end
        time2 = emb_state.recv_timestamp-emb_state.recv_timestamp(1);

        %interpOp function used to correct timescale differences
        [timex_diff, x_diff] = interpOp(time1,plan_x,time2,act_x,'-');
        [timey_diff, y_diff] = interpOp(time1,plan_y,time2,act_y,'-');
        [timey_diff, z_diff] = interpOp(time1,plan_z,time2,act_z,'-');

        time_diff = (timex_diff + timey_diff)/2;


        clear timex_diff timey_diff;

%         x_diff = abs(x_diff);
%         y_diff = abs(y_diff);
%         z_diff = abs(z_diff);
        path_diff = sqrt(x_diff.^2 + y_diff.^2 + z_diff.^2);
if exist('pos_con_telemetry','var')
    % Checking the math using the P-terms (proportional error term for position)
        pos_con_telemetry.pos_x_con_telem_error = pos_con_telemetry.pos_x_con_telem_ref - pos_con_telemetry.pos_x_con_telem_meas;
        pos_con_telemetry.pos_y_con_telem_error = pos_con_telemetry.pos_y_con_telem_ref - pos_con_telemetry.pos_y_con_telem_meas;
        pos_con_telemetry.pos_z_con_telem_error = pos_con_telemetry.pos_z_con_telem_ref - pos_con_telemetry.pos_z_con_telem_meas;
        p_terms_diff = sqrt((pos_con_telemetry.pos_x_con_telem_error).^2 + (pos_con_telemetry.pos_y_con_telem_error).^2 + (pos_con_telemetry.pos_z_con_telem_error).^2);
        p_time = pos_con_telemetry.recv_timestamp(end)-pos_con_telemetry.recv_timestamp(1);
        dev = std(p_terms_diff);
        poscon = 1;
else
        poscon = 0;
end

    % score.start_timestamp = start_timestamp;
    % score.end_timestamp = end_timestamp;
    % score.flight_time =  flight_time;
    % score.takeoff_timestamp = takeoff_timestamp;
    % score.landing_timestamp = landing_timestamp;
    % score.path_diff = path_diff;
    % score.time_diff = time_diff;
    % score.p_terms_diff = p_terms_diff;
    numb = [0:0.001:10];
    for i = 1:length(numb)
        if poscon
            score.pos_con_score(i) = 100 - sum(p_terms_diff > numb(i))/(p_time(end));
        end
        score.calculated_score(i) = 100 - sum(path_diff > numb(i))/(time_diff(end));
    end
     score.tolerance_score = 100 - sum(path_diff>5)/(time_diff(end));

    assignin('base','score',score);

% flight score plot

    if ~exist('poscon','var')
        poscon = 0;
    end
    if poscon
        lim1 = numb(score.pos_con_score == max(score.pos_con_score));
        lim1 = lim1(1);
    else
        lim1 = numb(score.calculated_score == max(score.calculated_score));
        lim1 = lim1(1);
    end
    done = 16;
end        
if done == 16    
    figure('Name','flightscore','WindowStyle','docked');
    grid on;
    hold on;
    if poscon
        plot(numb,score.pos_con_score);
        plot(numb(1:end-1),movingmean(diff(score.pos_con_score')*1000,100));
    else
        plot(numb,score.calculated_score);
        plot(numb(1:end-1),movingmean(diff(score.calculated_score')*1000,100));
    end
    %set(gca,'XTick',[0:dev:10*dev]);  
    xlim([0 lim1]);
    ylabel('percentage');
    xlabel('meters off path');
    legend('recorded telemetry errors','diff of error score');
    %fprintf('flight score is %.3f\n',score.pos_con_score);
end