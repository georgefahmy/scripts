function lidarplotter(file)
%% lidar plotter
%
if ~exist('lidar','var')
    lidar = importdata(file);
end

raw_dist = lidar.raw_distance;
pos_z = -emb_state.translation_z;

sample_size = length(raw_dist);
time = [1:1:sample_size];

flying = time(pos_z >= max(pos_z)-20);

temp1 = time(flying(1));
temp2 = time(flying(end));

first_sample = temp1;
last_sample = temp2;

count = 0;

for i = 1:length(raw_dist)
    if raw_dist(i) >= 51
        raw_dist(i) = 51;
    end
end

for i = first_sample:length(raw_dist(first_sample:last_sample))
    if raw_dist(i) < 51
        count = count+1;
    end
end

noise = (count/sample_size)*100;
fprintf('%.3f percent of lidar data below 51m\n',noise);

figure('Name','Lidar Raw Distance');
scatter([1:1:sample_size],raw_dist,'.');
grid on;

