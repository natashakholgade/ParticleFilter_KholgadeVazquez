function [specs,D]=loadmap(mapfilename)

fid=fopen(mapfilename);

C=textscan(fid,'%s %d',5);
fgetl(fid);

specs=C{2}';
C1=textscan(fid,'%s %d %d',1);
n=C1{end-1};
m=C1{end};

C2=textscan(fid,'%f');
D=C2{1};
D=reshape(D,n,m);

fclose(fid);

end