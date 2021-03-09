% This script is used for speckle pattern simulation
% Ref: B. Pan, H.M. Xie, B.Q. Xu, F.L. Dai, Performance of sub-pixel registration algorithms in digital image correlation, Meas. Sci. Technol. 17 (2006) 1615?1621.
% Author: Bin Chen;
% E-mail: cbbuaa@outlook.com
% Update: 2021-03-09

% Define parameters for reference image
close,clear,clc;
imSize     = [4000,6000];
numSpeGran = 15000;
R          = 25;

if 0
    imSize     = [400,600];
    numSpeGran = 15000;
    R          = 2.5;
end

size_X = imSize(1);
size_Y = imSize(2);
xkRand     = size_X*rand(numSpeGran,1);
ykRand     = size_Y*rand(numSpeGran,1);
Ik         = 255*rand(numSpeGran,1);

% Generate the reference and deformed images
ImgRef     = uint8(zeros(imSize));


parfor i = 1:size_X
    for j = 1:size_Y
        deltax      = i-xkRand;
        deltay      = j-ykRand;
        ExpodentRef = -(deltax.^2+deltay.^2)/R^2;
        
        ImgRef(i,j) = round(sum(Ik.*exp(ExpodentRef)));
    end
end

% show and save images
figure,
imshow(ImgRef);
imwrite(ImgRef,'img_00000.bmp')



