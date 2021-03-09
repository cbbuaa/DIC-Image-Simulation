% Generate a set of simulated translated images by downsampling 
% a high-resolution image;
% the generated images have the displacment of 1:0.1:1 pixels
% Ref: P.L. Reu, Experimental and Numerical Methods for Exact Subpixel Shifting, Exp. Mech. 51 (2011) 443?452.
% Author: Bin Chen;
% E-mail: cbbuaa@outlook.com
% Update: 2021-03-09

clc;clear;close all;
% Select an image as reference image.
[Filename, Pathname]=uigetfile({'*.bmp'},'Open data');
ImageName = fullfile(Pathname,Filename);
Img       = imread(ImageName);

imwrite(Img,fullfile(Pathname,'img_00000.bmp'));
Img_size  = size(Img);
Img       = double(Img);
% generate deformation images with a constant displacements. 

numStr = repmat('0',1,5);
file_dir = cd;
t = 0;
for i = 0:10
    t = t+1;
    % the displacement along two dimensions;
    shift = [i*0.1,0];
    
    shiftedLargeImg = Img(11-i:(floor(Img_size(1)/10))*10-i,...
        1:(floor(Img_size(2)/10)-1)*10);
    imgSmallSize = [floor(Img_size(1)/10)-1,floor(Img_size(2)/10)-1];
    shiftedSmallImg = zeros(imgSmallSize);
    for j = 1:10
        for k = 1:10
        shiftedSmallImg = shiftedSmallImg+...
            shiftedLargeImg((0:imgSmallSize(1)-1)*10+j,(0:imgSmallSize(2)-1)*10+k);
        end
    end
    shifted_image = shiftedSmallImg./100;
    
    % save the generated images;
    n = ceil(log10(i+1));
    if n == 0
        numStr(end) = num2str(i);
    else
        numStr(end-n+1:end) = num2str(i);
    end
    imagename = strcat(Pathname,'img_',numStr,'.bmp');
    imwrite(uint8(shifted_image),imagename);
    
    % save the deformation values for all points
    dataRef_name{t} = strcat(Pathname,'img_',numStr,'_dataRef.mat');
    [x,y]      = ndgrid(1:imgSmallSize(1),1:imgSmallSize(2));
    u          = shift(1)*ones(imgSmallSize);
    v          = shift(2)*ones(imgSmallSize);
    exx        = zeros(imgSmallSize);
    exy        = zeros(imgSmallSize);
    eyy        = zeros(imgSmallSize);
     
    dataRef.strain  = [exx(:),eyy(:),exy(:)];
    dataRef.disp    = [u(:),v(:)];
    dataRef.realPts = [x(:)+u(:),y(:)+v(:)];
    dataRef.imgName = dataRef_name{t};
    save(dataRef_name{t},'dataRef')
end