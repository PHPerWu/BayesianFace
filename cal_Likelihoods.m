%Pass the whitened image matrix,whitened input image vector and the normalizing denominator into the function
[MLresult,index]= cal_Likelihoods (transVecMat,whitenedImgVec,normalizing_denom);
 
%% Get the filename of the image found before displaying 
 
if(mod(index,2)==0)
 
    strimgname=strcat(int2str(index/2),'b');
 
else
 
    strimgname=strcat(int2str(index/2),'a');
 
end
 
%Show the filename
 
strimgname
 
%Show the input image for feedback purpose
figure(6);
 
strfilepath=inputimage;
img=imread(strfilepath);
    img=histeq(img,255);
subplot(ceil(sqrt(M)),ceil(sqrt(M)),i)
    imshow(img)
    drawnow;
 
%Show the image found for feedback purpose
figure(5);
 
 
strfilenamea=strcat(strimgname, '.png');
    strfilepath=strcat(filepath, strfilenamea);
    img=imread(strfilepath);
    img=histeq(img,255);
subplot(ceil(sqrt(M)),ceil(sqrt(M)),i)
    imshow(img)
    drawnow;