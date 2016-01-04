function [transVecMat]= perform_whitening(Vectors, Values,imgM,subDim)
 
%Vectors: Eigenvectors obtained from the eigenspace decomposition
 
%Values: Eigenvalues obtained from the same decomposition
 
%imgM: Matrix of image column vectors
 
%subDim: The number of desired top eigenvalues
 
%first I had to take the square root of Values before creating the diagonal matrix, or else it will consists of Inf's
 
DiagVal=[];
TempVal=[];
 
w=[];
for i =1:subDim
 
    TempVal(i) = (Values(i))^(-1/2);
 
end
 
DiagVal= diag(TempVal);
 
transVecMat=[];%The matrix to hold the whitened image vectors
 
for i=1:size(imgM,2)
    transVecMat(:,i) = DiagVal * Vectors'* double(imgM(:,i)); %Perform whitening
end
