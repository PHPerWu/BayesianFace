function  train2( )
%TRAIN2 Summary of this function goes here
%   Detailed explanation goes here
M=15;
DimDesired=30;
img_matrix=[];
imgMatrixA=[];
imgMatrixB=[];
for i=1:M
    img0=imread(strcat('F:\1\4\',num2str(i),'.png')); 
    img=rgb2gray(img0);
    sizeA=prod(size(img));
    img=reshape(img', sizeA,1); %Convert it into a column vector
    img_matrix =[img_matrix img]; % Put it into the image vector matrix
    imgMatrixA =[imgMatrixA img]; %Put it into another matrix to calculate the intrapersonal difference
 

    
   img0=imread(strcat('F:\1\4\',num2str(31-i),'.png'));
    img=rgb2gray(img0);
    sizeA=prod(size(img));
    img=reshape(img', sizeA,1); %Convert it into a column vector
    img_matrix =[img_matrix img];% Put it into the image vector matrix
 
    imgMatrixB =[imgMatrixB img];%Put it into another matrix to calculate the intrapersonal difference
 
end

%{
Calculation of intrapersonal differences

The next step is to calculate the intrapersonal differences 
(i.e the differences between images of the same individual).
To do that I took each of the image column vectors 
in ImgMatrixA and subtract it with another one with the same index 
in ImgMatrixB.Then I subtracted the vectors the other way around. 
This is make sure that the mean of the differences are zero.
 Here is the code for that:
%}
for i =1:M
ImgDifVecs(:,i) = imgMatrixA(:,i) - imgMatrixB(:,i); % Calculate the difference between an image from imgMatrixA and that from imgMatrixB 
 
ImgDifVecs(:,i+1) = imgMatrixB(:,i) - imgMatrixA(:,i);% Calculate the difference the other way around


%Selection of eigenvectors
[Vectors,Values,Psi,IntraCovMat] = pc_evectors(ImgDifVecs,DimDesired); % Pass the intrapersonal difference vectors and the number of eigenvectors 

end

