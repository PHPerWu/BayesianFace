function [normalizing_denom] = cal_normalizingDenom(Values,DimDesired)
 
%Values: Eigenvalues obtained from the eigenspace decomposition of intrapersonal difference vectors
%DimDesired:Number of top largest eigenvalues to be taken
 
 
normalizing_const = 2*pi;
 
 
normalizing_const= normalizing_const ^(DimDesired/2); % This is the constant as specified in the first part of the normalizing formula
 
subVal=[];
 
 subVal=Values(1:DimDesired);
 
 temp=1;
 
 for i =1:DimDesired
     temp =temp * subVal(i); % Calculate the determinant of the covariance matrix
 end
 
normalizing_denom = normalizing_const * (temp)^(1/2); % Final calculation of the denominator