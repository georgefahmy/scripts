%% overlay plot
if exist('high_controller_diag_plan','var') && exist('emb_state','var') || exist('path_target','var')
    overlay_plot = figure('Name','overlay_plot','WindowStyle','docked');
    if exist('path_target','var')
        plot(path_target.position_y(1:end),...
             path_target.position_x(1:end),'DisplayName','path targets')
    else
        plot(high_controller_diag_plan.plan_translation_y(1:end),...
             high_controller_diag_plan.plan_translation_x(1:end),'DisplayName','path target');
    end
    hold on;
    grid on;
    plot(emb_state.translation_y(1:end),...
         emb_state.translation_x(1:end),'DisplayName','emb state');
    plot(gps_state.translation_y,...
         gps_state.translation_x,'DisplayName','gps state');
    plot(poly2(:,1)*111319.458*(cosd(meta.home(2))),...
         poly2(:,2)*111319.458,'DisplayName','capture area');
    legend('-DynamicLegend','Location','best');
    plot(0,0,'o');
    if exist('gps_event','var')
        scatter(gps_event.translation_y2,...
                gps_event.translation_x2,'DisplayName','image events');
    end
    if exist('geotags','var')
        scatter(geotags.translation_y,...
                geotags.translation_x,'DisplayName','geotags');
    end
    hold off;
    title('path target Capture Area Overlay');
    xlabel('longitude, y');
    ylabel('latitude, x');

    daspect([1 1 1]);
%%
    path3d = figure('Name','3d_path_target','WindowStyle','docked');
    if exist('path_target','var')
        plot3(path_target.position_y(1:50:end),...
              path_target.position_x(1:50:end),...
             -path_target.position_z(1:50:end),'DisplayName','path target');
    else
        plot3(high_controller_diag_plan.plan_translation_y(1:50:end),...
              high_controller_diag_plan.plan_translation_x(1:50:end),...
             -high_controller_diag_plan.plan_translation_z(1:50:end),'DisplayName','path target');
    end
    hold on;
    plot3(emb_state.translation_y(1:50:end),...
          emb_state.translation_x(1:50:end),...
         -emb_state.translation_z(1:50:end),'DisplayName','emb state');

    if exist('gps_event','var')
        scatter3(gps_event.translation_y2,...
                 gps_event.translation_x2,...
                 gps_event.translation_z-meta.act_alt,'DisplayName','image events');
    end
    if exist('geotags','var')
        scatter3(geotags.translation_y,...
                geotags.translation_x,...
                geotags.alt - meta.act_alt,'*','DisplayName','geotags');
    end
    shading interp;camlight;axis tight;
    %first view
    camproj('perspective');
    grid on;
    xlabel('y');
    ylabel('x');
    zlabel('z');
    daspect([1 1 1]);
    hold off;
    legend('-DynamicLegend','Location','best');
end