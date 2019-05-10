function d=my_gaussian(src,n,k)  
  
n1=(n+1)/2;                                         %%%gaussian center 
[m,l]=size(src);  
a=zeros(n,n);                                       %%%zero metrix   
I=zeros(m,l);  
d=zeros(m,l);  
img=zeros(m,l);  

%%%%%%%%%%%%%%%%%Gaussian model%%%%%%%%%%%%%%
for i=1:n  
    for j=1:n  
          a(i,j)=(exp(-((i-n1)^2 +(j-n1)^2)/(2*k)))/(2*pi*k);  
    end  
end

% Img1=conv2(src,a,'same'); 
% d=uint8(Img1);

a = a/sum(a(:));        
I=double(src);  


%%%%%%%%%%%%%%% calculate 2D convolution %%%%%%%%%%%%%%
conv=im2double(a);
[ix,iy]=size(I);
[cx,cy]=size(conv);

jx=ix-cx+1;                     % get the size of output metric
jy=iy-cy+1;

for i=1:1:jx
	for j= 1:1:jy
        summ = 0;
        for ii = 1:cx          
            for jj = 1:cy
                summ = summ + I(i+cx-ii, j+cy-jj) * conv(ii, jj);
            end
        end
        img(i,j)=summ;
	end
end

d=uint8(img);                               
  
end  