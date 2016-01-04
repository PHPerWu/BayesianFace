function [MLresult,index]= cal_Likelihoods (WhitenVecs,ImgColVec,normalizing_denom)
 
%WhitenVecs:Whitened vectors of the training images
%ImgColVec:Whitened input image vector
%normalizing_denom: Normalizing denominator previously calculated
 
likelihoods=[];
 
DBsize=size(WhitenVecs,2);
 
for i= 1:DBsize
 
    temp = ImgColVec - WhitenVecs(:,i);%Subtract the input image from each of the image in the training set
 
    tempnorm = (-1/2)*((norm(temp))^2); %Calculate the norm
 
    likelihoods(i) = exp(tempnorm)/normalizing_denom; % Normalize the result
 
end
 
[MLresult,index]=max(likelihoods);%Return the largest ML value and the index of the value