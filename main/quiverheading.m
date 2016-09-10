%% quiver3 script for heading display
%this script calculates and plots the heading of the drone according to the
%quaternian it has stored in the recording files.

u = sin(emb_state.yaw);
v = cos(emb_state.yaw);
w = 0*([1:1:length(emb_state.yaw)])';

if exist('path_target','var')
u2 = sin(path_target.yaw);
v2 = cos(path_target.yaw);
w2 = (0*[1:1:length(path_target.yaw)])';
elseif exist('high_cmd','var')
u2 = sin(high_cmd.yaw_cmd);
v2 = cos(high_cmd.yaw_cmd);
w2 = (0*[1:1:length(high_cmd.yaw_cmd)])';
end
u3 = cos(emb_state.yaw);
v3 = sin(emb_state.yaw);
w3 = 0*([1:1:length(emb_state.yaw)])';


if isequal(length(emb_state.translation_x), length(u), length(u2))
    minval = length(emb_state.translation_x);
elseif ~isequal(length(emb_state.translation_x), length(u), length(u2))
    minval = min([length(emb_state.translation_x) length(u) length(u2)]);
end
v = v(1:minval);
u = u(1:minval);
w = w(1:minval);
v2 = v2(1:minval);
u2 = u2(1:minval);
w2 = w2(1:minval);
v3 = v3(1:minval);
u3 = u3(1:minval);
w3 = w3(1:minval);

emb_state.x = emb_state.translation_x(1:minval);
emb_state.y = emb_state.translation_y(1:minval);
emb_state.z = emb_state.translation_z(1:minval);

   
%%%%%%%%%%
heading3 = figure('Name','3d heading','WindowStyle','docked');
quiver3(emb_state.y(1:50:end),emb_state.x(1:50:end),-emb_state.z(1:50:end),u(1:50:end),v(1:50:end),w(1:50:end),.5);
hold on;
grid on;
quiver3(emb_state.y(1:50:end),emb_state.x(1:50:end),-emb_state.z(1:50:end),u2(1:50:end),v2(1:50:end),w2(1:50:end),.5);
plot3(emb_state.translation_y,emb_state.translation_x,-emb_state.translation_z);
if exist('path_target','var')
    plot3(path_target.position_y,path_target.position_x,-path_target.position_z);
elseif exist('high_cmd','var')
    plot3(high_cmd.pos_cmd_y,high_cmd.pos_cmd_x,-high_cmd.pos_cmd_z);
end
legend('drone heading','target heading','drone path','target path');
camproj('perspective');
%%%%%%%%%%
heading = figure('Name','2d_heading','WindowStyle','docked');
quiver(emb_state.y(1:50:end),emb_state.x(1:50:end),u(1:50:end),v(1:50:end));
hold on;
grid on;
quiver(emb_state.y(1:50:end),emb_state.x(1:50:end),u2(1:50:end),v2(1:50:end));
plot(emb_state.translation_y,emb_state.translation_x);
if exist('path_target','var')
    plot(path_target.position_y,path_target.position_x);
elseif exist('high_cmd','var')
    plot(high_cmd.pos_cmd_y,high_cmd.pos_cmd_x);
end
legend('drone heading','target heading','drone path','target path');
daspect([1 1 1]);
%%%%%%%%%%
