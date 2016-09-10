function [yes] = yesplotter
d = dialog('Name','Plotter','Position',[600 600 100 100]);

txt = uicontrol('Parent',d,...
               'Style','text',...
               'Position',[2 60 100 40],...
               'String','Run all Plots?');
      
           btn  = uicontrol('Parent',d,...
               'Position',[10 20 40 20],...
               'String','Yes',...
               'Callback',@notno);
           btn2 = uicontrol('Parent',d,...
               'Position',[50 20 40 20],...
               'String','No',...
               'Callback',@no);
    
    uiwait(d);
    
    function notno(btn,callbackdata)
        yes = 1;
        delete(gcf);    
    end
           
    function no(btn2,callbackdata)
        yes = 0; 
        delete(gcf);    
    end
end
    