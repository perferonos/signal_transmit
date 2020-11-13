n=31;
k=26;
s=1;

%making data

msg=randint(1,k,[0,1]); % random signal
msg=de2bi(msg); % making message binary
code = encode(msg,n,k,'cyclic/binary')';
noisycode = rem(code + randerr(1,n,[0 1;.1 .9]), 2);

fid=fopen('input2.txt','w');
if fid == -1 
    error('File is not opened'); 
end 

fprintf(fid,'%d\n',noisycode');
fclose(fid);