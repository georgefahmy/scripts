%% Drone Height Analysis


if  exist('plan_data','var')

        flightdata.avevelocity = flightdata.plan_distance/(flightdata.flighttime*60);
        fprintf('\nAverage Velocity: %.2f\n',flightdata.avevelocity);

    if exist('area','var')
        fprintf('Capture area is %.2f square meters, %.2f acres.\n\n',area,flightdata.area);
    end

        flightvars = {'Corners','Flight Time (m)','Distance (m)','Corner Time (s)'};

        fprintf('Flight ID is : %.0f\n',flightid);

    %storing path error into the flightdata structure
%     if exist('pid_data','var')
%         flightdata.path_error = flight_score.path_error_p;  
%     end
        format;

    
end