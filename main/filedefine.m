for i = 1:length(files)
    
        %each of these temp variables defines the files we need using regexp
        [a,b,c,temp0] = regexp(files(i).name,'^_results$');
        temp1 = regexp(files(i).name,'emb_command.t+');
        if temp1
        drone = files(i).name(1:temp1(1)-2);
        end
        if exist('drone','var')
            if drone(1) == 'o'
                dronetype = 1;
            else 
                dronetype = 0;
            end
        else
            dronetype = 0;
            drone = 'unknown';
        end
        temp2 = regexp(files(i).name,'emb_state.t+');
        temp3 = regexp(files(i).name,'diag_PID.t+');
        temp4 = regexp(files(i).name,'diag_plan.t+');
        temp5 = regexp(files(i).name,'meta.json');
        temp6 = regexp(files(i).name,'emb_sensor.t+');
        temp7 = regexp(files(i).name,'emb_controller.t+');
        temp8 = regexp(files(i).name,'command_interface_status.t+');
        temp9 = regexp(files(i).name,'resuts.txt');
        temp10 = regexp(files(i).name,'results.txt');
        temp11 = regexp(files(i).name,'emb_mgmt.t+');
        temp12 = regexp(files(i).name,'system_monitor.t+');
        temp13 = regexp(files(i).name,'gps_state.t+');
        temp14 = regexp(files(i).name,'path_target.t+');
        temp15 = regexp(files(i).name,'emb_estimator.t+');
        temp16 = regexp(files(i).name,'high_controller_diag_commands.t+');
        temp17 = regexp(files(i).name,'pos_con_telemetry.t+');
        temp18 = regexp(files(i).name,'kbox_health.t+');
        temp19 = regexp(files(i).name,'sensor_x86.t+');
        %temp20 = regexp(files(i).name,'\.');
        temp21 = regexp(files(i).name,'lidar.t+');
        temp22 = regexp(files(i).name,'mission_progress.t+');
        temp23 = regexp(files(i).name,'att_con_telem.t+');
        temp24 = regexp(files(i).name,'att_rate_con_telem.t+');
        temp25 = regexp(files(i).name,'baro.t+');
        temp26 = regexp(files(i).name,[drone '.gps_ubx_nav_pvt.tsv']);
        done  = regexp(files(i).name,'quickresults.txt');
        
        if ~isempty(temp0)
            loaddata;
            break
            return
        end
        
        
        if temp1
        drone = files(i).name(1:temp1(1)-2);
        end
        if exist('drone','var')
            if drone(1) == 'o'
                dronetype = 1;
            else 
                dronetype = 0;
            end
        else
            dronetype = 0;
            drone = 'unknown';
        end
     
        if temp26
            gps_info_file = [pathname '/' files(i).name];
        end
        if temp21
            lidar_file = [pathname '/' files(i).name];
        end
        if temp22
            mission_file = [pathname '/' files(i).name];
        end
        if temp23
            att_con_file = [pathname '/' files(i).name];
        end
        if temp24
            att_rate_con_file = [pathname '/' files(i).name];
        end
        if temp25
            baro_file = [pathname '/' files(i).name];
        end
        if temp10
            results = [pathname '/' files(i).name];
        end
        if temp19
           sensor_x86_file = [pathname '/' files(i).name];
        end
        if temp9
            results = [pathname '/' files(i).name];
        end
        if temp1 
            emb_cmd_file    = [pathname '/' files(i).name];
        end
        if temp2
            emb_state_file  = [pathname '/' files(i).name]; 
        end
        if temp3
             emb_pid_file   = [pathname '/' files(i).name];
        end
        if temp4
             emb_plan_file  = [pathname '/' files(i).name]; 
        end 
        if temp5
             meta_data_file = [pathname '/' files(i).name]; 
        end
        if temp6
             emb_sensor_file = [pathname '/' files(i).name]; 
        end 
        if temp7
             emb_controller_file = [pathname '/' files(i).name]; 
        end 
        if temp8
            status_data_file = [pathname '/' files(i).name];
        end
        if temp11
            mgmt_data_file = [pathname '/' files(i).name];
        end
        if temp12
            sys_mon_file = [pathname '/' files(i).name];
        end
        if temp13
            gps_state_file = [pathname '/' files(i).name];
        end
        if temp14
            path_target_file = [pathname '/' files(i).name];
        end
        if temp15 
            if dronetype % 1 equal's ostrel
            emb_estimator_file = [pathname '/' files(i).name];
            elseif ~dronetype % 0 equal's hamilton
            emb_estimator_file_old = [pathname '/' files(i).name];
            end
        end
        if temp16
            high_controller_cmd_file = [pathname '/' files(i).name];
        end
        if temp17
            pos_controller_telemetry_file = [pathname '/' files(i).name];
        end
        if temp18
            kbox_health_file = [pathname '/' files(i).name];
        end
        if done
            quickresults = [pathname '/' files(i).name];
        end
end

temp = regexp(pathname,'/');
        if length(pathname) > 70
            flightid = pathname(temp(end)+1:end-15);
        else
            flightid = pathname(temp(end)+1:end);
        end

        if isempty(flightid) 
            flightdate =  unixtodate(flightid);
            disp(flightdate);
            disp(drone);
        end
        flightdata.flightid = str2double(flightid);
        disp(flightid);
        clear temp*
        skip = 0;