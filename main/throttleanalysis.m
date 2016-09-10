 if exist('emb_controller','var')
        emb_controller.leftyawmean = mean((emb_controller.throttle_w+emb_controller.throttle_y)./2);
        emb_controller.rightyawmean = mean((emb_controller.throttle_x+emb_controller.throttle_z)./2);
        emb_controller.frontmean = mean((emb_controller.throttle_w+emb_controller.throttle_x)./2);
        emb_controller.backmean = mean((emb_controller.throttle_y+emb_controller.throttle_z)./2);
        
      
        emb_controller.diff = (emb_controller.rightyawmean-emb_controller.leftyawmean)*4-.01;
        %positive is left bias, negative is right bias.
        
        emb_controller.meanthrottle = (emb_controller.throttle_w + emb_controller.throttle_x +...
                                       emb_controller.throttle_y + emb_controller.throttle_z )/4;
 end      