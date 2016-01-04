function  result=train(S1)



N=60;
MI=49;
ballsamples=[];
allsamples=[];%所有训练图像 
for i=1:MI    
    
        %a=imread(strcat(S1,num2str(i),'.png'));     
        a=imread(strcat('F:\1\4\',num2str(i),'.png'));   
        a=rgb2gray(a);
        b=zeros(1,N*N);
        b=a(1:N*N); % b是行矢量 1×N，其中N＝10304，提取顺序是先列后行，即从上到下，从左到右        
        b=double(b); 
        b=b/256;
        ballsamples=[ballsamples; b];  % allsamples 是一个M * N 矩阵，allsamples 中每一行数据代表一张图片，其中M＝200   

end
for i=1:MI-1
    for j=i:MI
        a=ballsamples(i,:)-ballsamples(j,:);
        allsamples=[ballsamples;a];
    end
end
samplemean=mean(allsamples); % 平均图片，1 × N  
%figure%平均图
%imshow(mat2gray(reshape(samplemean,N,N)));
for i=1:MI
    xmean(i,:)=allsamples(i,:)-samplemean; % xmean是一个M × N矩阵，xmean每一行保存的数据是“每个图片数据-平均图片” 
end;   
% figure%平均图
% imshow(mat2gray(reshape(xmean(1,:),112,92)));
sigma=xmean*xmean';   % M * M 阶矩阵 
[v,d]=eig(sigma);
d1=diag(d); 
[d2,index]=sort(d1); %以升序排序 
cols=size(v,2);% 特征向量矩阵的列数

for i=1:cols      
    vsort(:,i) = v(:, index(cols-i+1) ); % vsort 是一个M*col(注:col一般等于M)阶矩阵，保存的是按降序排列的特征向量,每一列构成一个特征向量      
    dsort(i)   = d1( index(cols-i+1) );  % dsort 保存的是按降序排列的特征值，是一维行向量 
end  %完成降序排列 %以下选择90%的能量 
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
title('前n个特征特占总的能量百分比');
xlabel('前n个特征值');
ylabel('占百分比');
figure
plot(a,dsort/dsum,'linewidth',2);
grid
title('第n个特征特占总的能量百分比');
xlabel('第n个特征值');
ylabel('占百分比');
i=1;  % (训练阶段)计算特征脸形成的坐标系
while (i<=p && dsort(i)>0)      
    base(:,i) = dsort(i)^(-1/2) * xmean' * vsort(:,i);   % base是N×p阶矩阵，除以dsort(i)^(1/2)是对人脸图像的标准化，特征脸
      i = i + 1; 
end   % add by wolfsky 就是下面两行代码，将训练样本对坐标系上进行投影,得到一个 M*p 阶矩阵allcoor  
% 
% for i=1:20
%   figure%平均图
% b=reshape(base(:,i)',112,92);%
% imshow(mat2gray(b));
% end

%allcoor = allsamples * base; accu = 0;   % 测试过程
for II=1:30
 % base=(mapminmax(base)+1)/2;
        a=imread(strcat('F:\1\7\',num2str(II),'.png')); 
        a=rgb2gray(a);
        b=a(1:N*N);        
        b=double(b);   
        b=b/256;
       % tcoor= b * base; %计算坐标，是1×p阶矩阵      
      %  tcoor=(mapminmax(tcoor)+1)/2;   
      accur=0;
        for ni=1:30
        a2=imread(strcat('F:\1\7\',num2str(ni),'.png')); 
        a2=rgb2gray(a2);
        b2=a2(1:N*N);        
        b2=double(b2);  
        b2=b2/256;
        tcoor= (b-b2) * base; %计算坐标，是1×p阶矩阵      
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

