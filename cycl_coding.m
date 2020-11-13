n=31;
k=26;
s=1;

%making data

msg=randint(1,k); % random signal
msg=de2bi(msg); % making message binary
polynom=cyclpoly(n,k); % generating polynomial
r=length(polynom); % n-k
mdop=zeros(r,1); % for zeroes addition 

%making signal

msgsig=[mdop;msg];
msgsig=de2bi(msgsig); % full message without mistakes

%making mistakes
rmis=(randerr(1,(r+k),[0 s;.01 .99])); % random mistakes
rmis=rmis';
rmiss=0;
if length(rmis) ~=1 % if there are mistakes
rlen=length(rmis);
zer=zeros(length(msgsig)-rlen,1);
rmiss=[rmis;zer]; % final mistakes vector
end
mismsg=gfadd(msgsig,rmiss); % mistakes addition
% check
count=0;
% checking correction
for i=1:(r+k)
    if mismsg(i,1)==msgsig(i,1)
        count=count+1;
    end
end
match=count/(r+k);
disp(match);

%inputting into file

fid=fopen('input.txt','w');
if fid == -1 
    error('File is not opened'); 
end 

fprintf(fid,'%d\n',mismsg);
fclose(fid);
% for checking output source message
fid=fopen('check.txt','w');
if fid == -1 
    error('File is not opened'); 
end 

fprintf(fid,'%d\n',msgsig);
fclose(fid);