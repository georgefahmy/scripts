%% lidar distance as a function of position
% lidar plotter as a function of distance
%

[~,lidar_strength] = interpOp(lidar.recv_timestamp,lidar.filtered_distance,emb_state.recv_timestamp,emb_state.recv_timestamp,'');
x = emb_state.translation_y(1:25:end);
y = emb_state.translation_x(1:25:end);
z = -emb_state.translation_z(1:25:end);
c = movingmean(lidar_strength,1);
c = c(1:25:end);
for i = 1:length(c)
    if c(i) >= 51
        c(i) = 0;
    end
end

lidar_heat = figure('Name','Lidar 3d','WindowStyle','docked');
plot4(x,y,z,c,0,51,'>');
colormap('jet')
grid on;
h = colorbar('ylim',[0 51],'Location','eastoutside');
caxis([0 51]);
set(h,'YTick', 0: 5: 51);
%daspect([1 1]);
set(lidar_heat,'Clipping','off');
    