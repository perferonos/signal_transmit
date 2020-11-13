n=31;
k=26;
s=1;
num=0;
min=n+1;
w=4;

fid = fopen('input.txt', 'rt');  % opening file input temporarily for debug
if fid == -1 
    error('File is not opened'); 
end 

% getting data
data2=fscanf(fid,'%f');
fclose(fid);
spol=data2'; % array for shifting
polynom1=cyclpoly(n,k,'min'); % generating polynomial
r=length(polynom1);
% deleting mistakes

buff=1;
while w > s && buff <= length(data2)  % still no
    num=0;
    [chast,ostat]=gfdeconv(spol,polynom1); % error endless cycle while
    for i=1:length(ostat) % counting the weight
        if ostat(i)==1
            num=num+1;
        end
    end
    if num<min
        min=num; % last minimum was 43
        ostmin=ostat;
    end
    if num <= s % if weight smaler than mistakes count
        w=num;
    else
        buff=buff+1; % illustrating endless process
        spol=circshift(spol,[0 -1]); % cyclic shift to the left
    end
end
if w > s
    error('incorrect deconv!');
end
if length(ostat) ~=1 % if there are mistakes
rlen=length(ostat);
zer=zeros(1,length(data2)-rlen);
rmiso=[ostat,zer]; % final mistakes vector
end
itog=gfadd(data2,rmiso');

fid=fopen('itog.txt','w');
if fid == -1 
    error('File is not opened'); 
end 

fprintf(fid,'%d\n',itog);
fclose(fid);
