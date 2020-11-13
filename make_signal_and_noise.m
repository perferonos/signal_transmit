logic1=5.0; % Logical one
logic0=0.1; % Logical zero
herzsec=10000; % Counts per second
pulsetime=10; % Time of one pulse - 1 or 0

%getting data

fid = fopen('input.txt', 'r');  
if fid == -1 
    error('File is not opened'); 
end 

% making source signal

data=fscanf(fid,'%f');
fclose(fid);
len=length(data);
lens=len*10;
timesigsecs=lens/herzsec; % time of all signal in seconds
timeaxis=(1:lens);
amplitude=(1:lens);
ibeg=1;
iend=pulsetime;
for i=1:len % Making amplitude array
    if data(i)==1 % If we see 1 we put 10 vals of logic1 into array of amplitudes
        for j=ibeg:iend % Same with 0
        amplitude(j)=logic1;
        end
        ibeg=ibeg+pulsetime;
        iend=iend+pulsetime;
    else
        for j=ibeg:iend
        amplitude(j)=logic0;
        end
        ibeg=ibeg+pulsetime;
        iend=iend+pulsetime;
    end
end

% making noise

noise=(rand(1,lens)*2-1)*2;
amplitude=amplitude+noise;
% output

disp(amplitude);
disp(timesigsecs);
plot(timeaxis,amplitude);
grid on;

% outputting data in file

fid=fopen('output_signal.txt','w');
if fid == -1 
    error('File is not opened'); 
end 

fprintf(fid,'%d\n',amplitude);
fclose(fid);