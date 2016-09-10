%% Area Calculation

%calculate the total area
if exist ('meta','var') && isfield(meta,'poly') && isfield(meta,'home')

    deg = mean(meta.poly(:,2));
    lat = deg*pi/180;

    area = polyarea(((meta.poly(:,1)-meta.home(:,1))*111120*cos(lat)),(meta.poly(:,2)-meta.home(:,2))*111120);% square meters
    flightdata.area = area*0.0002471054; %Acres  

    flightarea = polyarea(emb_state.translation_x(2:end),emb_state.translation_y(2:end))*0.0002471054*2.75; %acres
    height = max(-emb_state.translation_z);  
end

%     if exist('plan_data','var') || exist('path_data','var')
%         plan_data.velocity = sqrt(plan_data.velx.^2 + plan_data.vely.^2 + plan_data.velz.^2);
%     end
