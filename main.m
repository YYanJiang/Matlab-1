clear all;
close all;

pic1=imread('kangaroo.pgm');
pic2=imread('plane.pgm');
pic3=imread('red.pgm');

pic = pic2;
sigma = 9;

subplot(2,2,1);imshow(pic);title('origin');  

%%%%%%%%%%%%%%Gaussian Filter%%%%%%%%%%%%%%

pic_gaussion=my_gaussian(pic,3,sigma);           

subplot(2,2,2);imshow(pic_gaussion);title('Gaussian');  


%%%%%%%%%%%%%%sobel gradient%%%%%%%%%%% 

[m,n] = size(pic_gaussion);       
F = double(pic_gaussion);       
pic_sobel = pic_gaussion; 
pic_sobel_x = double(pic_gaussion);
pic_sobel_y = double(pic_gaussion);

for i = 2:m - 1                         %sobel filter
    for j = 2:n - 1
        Gx = (F(i+1,j-1) + 2*F(i+1,j) + F(i+1,j+1)) - (F(i-1,j-1) + 2*F(i-1,j) + F(i-1,j+1));
        pic_sobel_x(i,j) = Gx;
        Gy = (F(i-1,j+1) + 2*F(i,j+1) + F(i+1,j+1)) - (F(i-1,j-1) + 2*F(i,j-1) + F(i+1,j-1));
        pic_sobel_y(i,j) = Gy;
        pic_sobel(i,j) = sqrt(Gx^2 + Gy^2); 
    end
end 


subplot(2,2,3);imshow(pic_sobel);title('sobel');  

  
%%%%%%%%%%%%%% 4 drection of gradient %%%%%%%%%%%%%%%%%%%%%%%  
 angel=zeros(m,n);
 
for i=1:m  
    for j=1:n  
        x=pic_sobel_x(i,j);  
        y=pic_sobel_y(i,j);
        
        if y~=0  
            a=atan(x/y);                  %vertical  
        elseif y==0 && x>0  
            a=pi/2;  
        else  
            a=-pi/2;              
        end  
          
        if ((a>=(-22.5/180*pi)&&a<(22.5/180*pi))||(a>=(157.5/180*pi)&&a<=pi)||(a<=(-157.5/180*pi)&&a>=-pi))  
            d1=0;
        elseif ((a>=(22.5/180*pi)&&a<(67.5/180*pi))||(a>=( -157.5/180*pi ) && a<(-112.5/180*pi)))  
            d1=-45;  
        elseif ((a>=(67.5/180*pi)&&a<(112.5/180*pi))||(a>=(-112.5/180*pi) && a<-67.5/180*pi))     
            d1=90;  
        else        
            d1=45;  
         end  
            angel(i,j)=d1;  
    end  
end  
  
  


%%%%%%%%%%%%%%%%%%Non-maximun suppression%%%%%%%%%%%%%%%%%%%%%%%

pic_non = pic_sobel;

for i=3:m-2  
    for j=3:n-2
        a = abs(pic_non(i,j));
        
        if(angel(i,j)==0)
            A=[pic_non(i-1,j),pic_non(i+1,j)];
            if(a< max(abs(A))) 
                pic_non(i,j)=0;
            end
            
        elseif(angel(i,j)==45)  
            A=[pic_non(i-1,j+1),pic_non(i+1,j-1)];
            if(a< max(abs(A)))  
                pic_non(i,j)=0;  
            end
            
        elseif(angel(i,j)==90)  
            A=[pic_non(i,j-1),pic_non(i,j+1)];
            if(a< max(abs(A)))  
                pic_non(i,j)=0;  
            end
            
        elseif(angel(i,j)== -45)             
            A=[pic_non(i-1,j-1),pic_non(i+1,j+1)];
            if(a< max(abs(A)))  
               pic_non(i,j)=0;  
            end    
        end  
    end  
end  

subplot(2,2,4);imshow(pic_non);title('Non-Maximum');





