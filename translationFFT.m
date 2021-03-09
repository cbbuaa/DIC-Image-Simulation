% Generate a set of simulated translated images;
% Author: Bin Chen;
% E-mail: cbbuaa@outlook.com
% Update: 2021-03-08

clc;clear;close all;
% Select an image as reference image, which is saved as 'ref.bmp' in folder
% 'transl_img'. If the folder do not exist, it will be created.
[Filename, Pathname]=uigetfile({'*.bmp'},'Open data');
ImageName = fullfile(Pathname,Filename);
Img = imread(ImageName);

imwrite(Img,fullfile(Pathname,'img_00000.bmp'));
Img_size = size(Img);
% generate deformation images with a constant displacements. 

numStr = repmat('0',1,5);
file_dir = cd;
t = 0;
for i = 0:10
    t = t+1;
    % the displacement along two dimensions;
    shift = [i*0.1,0];
    
    shifted_image = imshiftFFT(shift,Img);
    
    % save the images in folder 'transl_img/';
    n = ceil(log10(i+1));
    if n == 0
        numStr(end) = num2str(i);
    else
        numStr(end-n+1:end) = num2str(i);
    end
    imagename = strcat(Pathname,'img_',numStr,'.bmp');
    imwrite(uint8(shifted_image),imagename);
    
    dataRef_name{t} = strcat(Pathname,'img_',numStr,'_dataRef.mat');
    [x,y]      = ndgrid(1:Img_size(1),1:Img_size(2));
    u          = shift(1)*ones(Img_size);
    v          = shift(2)*ones(Img_size);
    exx        = zeros(Img_size);
    exy        = zeros(Img_size);
    eyy        = zeros(Img_size);
    
    dataRef.strain  = [exx(:),eyy(:),exy(:)];
    dataRef.disp    = [u(:),v(:)];
    dataRef.realPts = [x(:)+u(:),y(:)+v(:)];
    dataRef.imgName = dataRef_name{t};
    save(dataRef_name{t},'dataRef')
end