function  result=train(S1)



N=60;
MI=49;
ballsamples=[];
allsamples=[];%����ѵ��ͼ�� 
for i=1:MI    
    
        %a=imread(strcat(S1,num2str(i),'.png'));     
        a=imread(strcat('F:\1\4\',num2str(i),'.png'));   
        a=rgb2gray(a);
        b=zeros(1,N*N);
        b=a(1:N*N); % b����ʸ�� 1��N������N��10304����ȡ˳�������к��У������ϵ��£�������        
        b=double(b); 
        b=b/256;
        ballsamples=[ballsamples; b];  % allsamples ��һ��M * N ����allsamples ��ÿһ�����ݴ���һ��ͼƬ������M��200   

end
for i=1:MI-1
    for j=i:MI
        a=ballsamples(i,:)-ballsamples(j,:);
        allsamples=[ballsamples;a];
    end
end
samplemean=mean(allsamples); % ƽ��ͼƬ��1 �� N  
%figure%ƽ��ͼ
%imshow(mat2gray(reshape(samplemean,N,N)));
for i=1:MI
    xmean(i,:)=allsamples(i,:)-samplemean; % xmean��һ��M �� N����xmeanÿһ�б���������ǡ�ÿ��ͼƬ����-ƽ��ͼƬ�� 
end;   
% figure%ƽ��ͼ
% imshow(mat2gray(reshape(xmean(1,:),112,92)));
sigma=xmean*xmean';   % M * M �׾��� 
[v,d]=eig(sigma);
d1=diag(d); 
[d2,index]=sort(d1); %���������� 
cols=size(v,2);% �����������������

for i=1:cols      
    vsort(:,i) = v(:, index(cols-i+1) ); % vsort ��һ��M*col(ע:colһ�����M)�׾��󣬱�����ǰ��������е���������,ÿһ�й���һ����������      
    dsort(i)   = d1( index(cols-i+1) );  % dsort ������ǰ��������е�����ֵ����һά������ 
end  %��ɽ������� %����ѡ��90%������ 
dsum = sum(dsort);     
dsum_extract = 0;   
p = 0;     
while( dsum_extract/dsum < 0.9)       
    p = p + 1;          
    dsum_extract = sum(dsort(1:p));     
end
a=1:1:MI
for i=1:1:MI
y(i)=sum(dsort(a(1:i)) );
end
figure
y1=ones(1,MI);
plot(a,y/dsum,a,y1*0.9,'linewidth',2);
grid
title('ǰn��������ռ�ܵ������ٷֱ�');
xlabel('ǰn������ֵ');
ylabel('ռ�ٷֱ�');
figure
plot(a,dsort/dsum,'linewidth',2);
grid
title('��n��������ռ�ܵ������ٷֱ�');
xlabel('��n������ֵ');
ylabel('ռ�ٷֱ�');
i=1;  % (ѵ���׶�)�����������γɵ�����ϵ
while (i<=p && dsort(i)>0)      
    base(:,i) = dsort(i)^(-1/2) * xmean' * vsort(:,i);   % base��N��p�׾��󣬳���dsort(i)^(1/2)�Ƕ�����ͼ��ı�׼����������
      i = i + 1; 
end   % add by wolfsky �����������д��룬��ѵ������������ϵ�Ͻ���ͶӰ,�õ�һ�� M*p �׾���allcoor  
% 
% for i=1:20
%   figure%ƽ��ͼ
% b=reshape(base(:,i)',112,92);%
% imshow(mat2gray(b));
% end

%allcoor = allsamples * base; accu = 0;   % ���Թ���
for II=1:30
 % base=(mapminmax(base)+1)/2;
        a=imread(strcat('F:\1\7\',num2str(II),'.png')); 
        a=rgb2gray(a);
        b=a(1:N*N);        
        b=double(b);   
        b=b/256;
       % tcoor= b * base; %�������꣬��1��p�׾���      
      %  tcoor=(mapminmax(tcoor)+1)/2;   
      accur=0;
        for ni=1:30
        a2=imread(strcat('F:\1\7\',num2str(ni),'.png')); 
        a2=rgb2gray(a2);
        b2=a2(1:N*N);        
        b2=double(b2);  
        b2=b2/256;
        tcoor= (b-b2) * base; %�������꣬��1��p�׾���      
      %  tcoor2=(mapminmax(tcoor2)+1)/2;
       md= tcoor.^2;
       su=sum(md);
       d=det(sigma);
        d=sqrt(d);
        result=exp((-0.5)*su)/d;
        disp(result);
  %    disp(su);
       end
     
end
%sigma=(mapminmax(sigma)+1)/2;

d=det(sigma);
d=sqrt(d);
result=exp((-0.5)*su)/d;
disp(result)   

end

