n=31;
k=26;
s=1;
bufferino=0;

fid = fopen('input2.txt', 'rt');  % opening file input temporarily for debug
if fid == -1 
    error('File is not opened'); 
end 

% getting data
noisycode2=fscanf(fid,'%f');
fclose(fid);
newmsg = decode(noisycode2,n,k,'cyclic');
fid=fopen('itog2.txt','w');
if fid == -1 
    error('File is not opened'); 
end 
fprintf(fid,'%d\n',newmsg);
fclose(fid);
