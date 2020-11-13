logic1=5.0; % Logical one
logic0=0.1; % Logical zero
pulsetime=10; % Time of one pulse - 1 or 0
count=0;

fid = fopen('input.txt', 'r');  
if fid == -1 
    error('File is not opened'); 
end 
data=fscanf(fid,'%f');
fclose(fid);

fid = fopen('output_signal.txt', 'rt');  % opening file 
if fid == -1 
    error('File is not opened'); 
end 

% getting data

data2=fscanf(fid,'%f');
fclose(fid);
N=length(data2); % number of counts
itoglen=N/pulsetime;
itog=(1:itoglen);
itbeg=1;
itend=pulsetime;
% filter data

for i=1:itoglen
    if (data2(itbeg)<(0.01+logic1/2))
        itog(i)=0;
        itbeg=itbeg+itend;
    else
        itog(i)=1;
        itbeg=itbeg+itend;
    end
end
% match check
for i=1:itoglen
    if itog(i)==data(i)
        count=count+1;
    end
end
match=count/itoglen;
% outputting data

fid=fopen('output.txt','w');
if fid == -1 
    error('File is not opened'); 
end 

fprintf(fid,'%d\n',itog);
fclose(fid);
disp(match);