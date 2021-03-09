% Generate a set of simulated images;
% Author: Bin Chen;
% E-mail: cbbuaa@outlook.com
% Update: 2021-03-08

function[imShift] = imshiftFFT(shift,Img)
    shift   = flip(shift);
    imgSize = size(Img);
    % mesh of fourier frequencies
    [x_f,y_f] = meshgrid(((-imgSize(2)/2):1:(imgSize(2)-1)/2)./imgSize(2),...
        ((-imgSize(1)/2):1:(imgSize(1)/2-1))./imgSize(1)); 
    
    F = fftshift(fft2( Img ));
    Fshift=  F.*exp(-1i*(2*pi.*(x_f*shift(1) + y_f*shift(2))) );
    imShift = real(ifft2(ifftshift( Fshift  )));
end