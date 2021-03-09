% Simulate deformed images with complicated deformation field.
% Author: Bin Chen;
% E-mail: cbbuaa@outlook.com
% Update: 2021-03-08

[filename,pathname] = uigetfile('*.bmp','Read simulated speckle image');
fileAll = dir(fullfile(pathname,'*.bmp'));
refImg = double(imread(fullfile(pathname,filename)));

Noise = 5;
Img_size = size(refImg);
% deformation setting

if 1
    % complicated deformaiton
    % u          = alpha*sin(2*pi.*x/p).*sin(2*pi.*y/p);
    % v          = 2*alpha*sin(2*pi.*x/p).*sin(2*pi.*y/p);
    A          = 0.2;
    p          = 200;
    [x,y]      = ndgrid(1:Img_size(1),1:Img_size(2));
    u          = A*sin(2*pi.*x/p).*sin(2*pi.*y/p);
    v          = 2*A*sin(2*pi.*x/p).*sin(2*pi.*y/p);
    ux         = 2*pi/p*A.*cos(2*pi.*x/p).*sin(2*pi.*y/p);
    uy         = 2*pi/p*A.*sin(2*pi.*x/p).*cos(2*pi.*y/p);
    vx         = 4*pi/p*A.*cos(2*pi.*x/p).*sin(2*pi.*y/p);
    vy         = 4*pi/p*A.*sin(2*pi.*x/p).*cos(2*pi.*y/p);

    exx        = ux;
    eyy        = uy;
    exy        = 1/2*(uy+vx);
end


% generate file names
for k = 1:length(Noise)        
    pathSpeckleNoise1{k}  = strcat(pathname,'imgNoise_',num2str(Noise(k)),'.bmp');
    [~,name,~]  = fileparts(pathSpeckleNoise1{k});
    dataRef_name{k} = strcat(pathname,'imgNoise_',num2str(Noise(k)),'_dataRef.mat');
end  

% image interpolation
x_interp = x+u;
y_interp = y+v;
Vq       = griddata(x_interp(:),y_interp(:),refImg(:),x(:),y(:),'cubic');
imInterp = reshape(Vq,Img_size);

imInterp(isnan(imInterp)) = 0;
imInterp(imInterp<0)      = 0;
imInterp(imInterp>255)    = 255;
imInterp = imInterp./255; 

% generate images with different noise level
for k = 1:length(Noise)
    imInterpNoise = imnoise(imInterp,'gaussian',0,(Noise(k)/255)^2);
    imwrite(imInterpNoise,pathSpeckleNoise1{k}); 
    % save results
    dataRef.strain  = [exx(:),eyy(:),exy(:)];
    dataRef.disp    = [u(:),v(:)];
    dataRef.realPts = [x(:)+u(:),y(:)+v(:)];
    dataRef.imgName = dataRef_name{k};
    save(dataRef_name{k},'dataRef')
end  