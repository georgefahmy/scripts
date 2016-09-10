function output = samefigchoice
    f = dialog('Name','Plot same Fig','Position',[500 300 130 60]);
    

        btn  = uicontrol('Parent',f,...
                   'Position',[20 30 40 20],...
                   'Style','pushbutton',...
                   'String','Yes',...
                   'Callback',@yes);
        btn2 = uicontrol('Parent',f,...
                   'Position',[70 30 40 20],...
                   'Style','pushbutton',...
                   'String','no',...
                   'Callback',@no);
        
               uiwait(f);
     
    function no(btn2,callbackdata)
        %uiwait(f)
        output = 0;
        uiresume(f);
        delete(gcf);
    end
 
    function yes(btn,callbackdata)
        %uiwait(f)
        output = 1;
        uiresume(f);
        delete(gcf);
    end
end