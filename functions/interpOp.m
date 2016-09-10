function [t, y] = interpOp(t1,x1,t2,x2,operation)
%INTERPOP 
%takes two variables with different time scales, interpolates
%so that arithmitic operation can be applied

%remove NaN's

%[x1 x1_keep]=removeItem( x1, NaN);
%t1=t1(x1_keep);
    
%[x2 x2_keep]=removeItem( x2, NaN);
%t2=t2(x2_keep);

    
%range check:  if t2 time range is greater or less than t1, NaN's will result
if max(t2) > max (t1)
%     hold last value
    t1=[t1; max(t2)]; 
    x1=[x1; x1(end)];
    
%     t1(end)=max(t2);   %this is a hack, should use above, but that lengthens x1 array which can be problematic.
    
    
end

if min(t1) > min (t2)
    %hold last value
    t1=[min(t2); t1]; 
    x1=[x1(1); x1];
    
%      t1(1)=min(t2);

end


%get a new x1 at times of t2.

x1_new=interp1(t1,x1,t2,'nearest');

%Flip so both columns or both rows
if size(x2,1)==1  %row vector
    if size(x1_new,2)==1 %column
        x1_new=x1_new';
    end
    
else %column vector
    if size(x1_new,1)==1 %row
        x1_new=x1_new';
    end
end


switch operation
    
    case '+'
         y=x1_new+x2;
        
    case '-'
        y=x1_new-x2;
        
    case '*'
        y=x1_new.*x2;
        
    case '/'
        y=x1_new./x2;
        
    case '^'
        y=x1_new.^x2;
        
    case ''
        %regular interpolation, with the error check provided by interpOp
        y=x1_new;
        
    otherwise
        %try to perform the operation
        y=eval('caller',[operation '(x1_new,x2)']);
        
        
end
        

t=t2;


end
