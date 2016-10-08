function lidarplotter(file)
% lidar plotter
%
lidar = importdata(file);
raw_dist = lidar.raw_distance;

sample_size = length(raw_dist);
count = 0;

for i = 1:length(raw_dist)
    if raw_dist(i) < 51
        count = count+1;
    end
end

noise = (count/sample_size)*100;
fprintf('%.3f percent of lidar data below 51m\n',noise);

figure('Name','Lidar Raw Distance');
plot(raw_dist);
grid on;

