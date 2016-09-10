%% path_target Playback
%[playback,finish] = playbackchoice;
%playback = 1;
    figure('Name','Path Playback','WindowStyle','docked');
    grid on;
    hold on;
    title('Drone path_target Playback');
    xlabel('x');
    ylabel('y');
    zlabel('z');
    shading interp;
    camlight;
    camproj('perspective');
    scatter3(0,0,0);
    set(gca, 'XLim', [min(emb_state.translation_y)-5 max(emb_state.translation_y)+5]);
    set(gca, 'YLim', [min(emb_state.translation_x)-5 max(emb_state.translation_x)+5]);
    set(gca, 'ZLim', [min(-emb_state.translation_z)-5 max(-emb_state.translation_z)+5]);
    daspect([1 1 1]);
    
    true = findobj('Type','figure','Name','Playback');
    u = sin(emb_state.yaw);
    v = cos(emb_state.yaw);
    w = 0*([1:1:length(emb_state.yaw)])';

    if exist('path_target','var')
    u2 = sin(path_target.yaw);
    v2 = cos(path_target.yaw);
    w2 = 0*[1:1:length(path_target.yaw)]';
    elseif exist('high_cmd','var')
    u2 = sin(high_cmd.yaw_cmd);
    v2 = cos(high_cmd.yaw_cmd);
    w2 = 0*[1:1:length(high_cmd.yaw_cmd)]';
    end
    u3 = cos(emb_state.yaw);
    v3 = sin(emb_state.yaw);
    w3 = 0*([1:1:length(emb_state.yaw)])';
    
    for i = 1:100:length(emb_state.translation_x)
        if ~ishandle(true)
            return
        end
        %plot3(emb_state.y(i),emb_state.x(i),-emb_state.z(i),'.');
        quiver3(emb_state.translation_y(i),emb_state.translation_x(i),-emb_state.translation_z(i),u(i),v(i),w(i),5.0);
        quiver3(emb_state.translation_y(i),emb_state.translation_x(i),-emb_state.translation_z(i),u3(i),-v3(i),w3(i),5.0);

        pause(0.02);   
    end 
