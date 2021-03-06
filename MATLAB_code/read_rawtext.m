file='/Volumes/Data/Dropbox/Scans/Output.txt'

fid=fopen(file,'r');
A=fscanf(fid,'%c')
fclose(fid);

%%
a=findstr(A,'$%@ begin filename:');
a=[a' [a(2:end)'-1;length(A)]];
files=cell(size(a,1),1);


M=cell(size(a,1),1);

for i=1:size(a,1)
B=A(a(i,1):a(i,2));

d=regexp(B,'/');
e=regexp(B,'\n');
e=e(1)-1;
d=d(d<=e);
d=d(end)+1;
files{i}=B(d:e);

b=regexp(B,'\s');
b=[[1;b(1:end-2)'+1],[b(1:end-2)'-1;length(B)-1 ]];
c=cell(length(b),1);
for j=1:length(c)
    c{j}=B(b(j,1):b(j,2));
end
M{i}=c;
if i==1
    allb=unique(c);
else
    allb=unique([allb;c]);
end
end

%%

data=zeros(size(M,1),length(allb));

for j=1:size(M,1)
for i=1:length(allb)
   A=strcmp(allb{i},M{j,1});
   if sum(A)>0
       data(j,i)=sum(A);
   end
end
j
end

%%

A=strncmp('page:',allb,5);
allb(A)=[];
data(:,A)=[];

A=sum(data>0)>=2;sum(A)
allb(A)
%%
clf
A=sum(data>0)>=5;
sum(A)

h=allb(A);
D=data(:,A);
D(D>0)=1;

%
[coeff,score,latent] = pca(D);

plot(score(:,1),score(:,2),'o');hold on

wtag='Basellandschaftliche';
A=strcmp(wtag,h);
if sum(A)>0
    B=D(:,A)>0;
    plot(score(B,1),score(B,2),'o')
end

coeff=coeff.*50;
plot(coeff(:,1),coeff(:,2),'*')

A=coeff(:,1)<-1
h(A)

%text(coeff(:,1),coeff(:,2),h)

%%
wtag={'[@�]'};
wtag=wtag(ones(length(allb),1));
A=cellfun(@isempty,cellfun(@regexp,allb,wtag,'UniformOutput',0))==0;
wtag={'[.]'};
wtag=wtag(ones(length(allb),1));
B=cellfun(@isempty,cellfun(@regexp,allb,wtag,'UniformOutput',0))==0;

sum(A&B)
allb(A&B)
EMAIL=A&B;
bar(sum(data(:,EMAIL)));hold on
text(1:sum(EMAIL),sum(data(:,EMAIL)),allb(EMAIL))

%% all arlesheim
clf
wtags={{'Domplatz','Gemeindeverwaltung','arlesheim.ch','706','95'};...
      {'sunnegarte','Sunnegarte','Stollenrain','Stiftung','Tagesfamilien'};...
      {'Basellandschaftliche','Kantonalbank','blkb.ch'};...
      {'SVA','Basel-Landschaft','info@sva-bl.ch'}};
A=zeros(length(allb),1);
wtag=wtags{4}
for i=1:length(wtag)
    B=strcmp(wtag{i},allb);
    if sum(B)>0
        A(B)=1;
    end
end
sum(A);
imagesc(data(:,A>0))

B=sum(data(:,A>0)>0,2)>=2;
sum(B)


files(B)
