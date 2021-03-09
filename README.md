# DIC-Image-Simulation

Simulate speckle pattern images and deformaed images for Digital Image Correlation (DIC)

To evaluate the algorithm performance of digital image correlation (DIC), simulated speckle pattern images with sub-pixel displacements or complicated deformaiton are generally required due to their advantages of immuning to many complicated errors and/or noises. 

## Introduction
This project is used to simulate speckle images and deformation images. There are **three** different ways. 
1. The first one is based on phase shift. It effective only for rigid-body translation, which is corresponding to file ``translationFFT.m``. 
2. The second one is based on interpolation. It is effective in more complicated situtations, which is corresponding to ``defImgSimu.m``.
3. The third one is based on downsampling. It is mainly used for image shift, which is corresponding to ``translationBinning.m``.

Simulation tests demonstrates that the third one, i.e., the one based on downsampling has the best performance.

## How o use
* Run `speckleSimu.m` to synthetic a speckle pattern image (e.g., img_00000.bmp, with size of 400 $\times$ 600 pixels);
* Create a new foler and put the reference image (such as `img_00000.bmp` in folder `test_img`) into this folder.
* Run ``translationFFT.m``, then 11 images with displacement of `[0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6 0.7, 0.8, 0.9, 1.0] pixels` along the first dimension and of 1 pixels along y dimenstions can be generated. 
* Run ``defImgSimu.m``, then one image with complicated deformation is obtained.
* Run `speckleSimu.m` to simulate a high-resolution speckle pattern image (e.g., 4000 $\times$ 6000 pixels). Then run `translationBinning.m`, one can get a set of simulated translation images (resoluton: 399 $\times$ 599 pixels)) with displacement of `[0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6 0.7, 0.8, 0.9, 1.0] pixels`.
  
## Note
* The deformation can be defined by the users, for example, changing the codes between `if 1 ... end` in `defImgSimu.m`, or changing the parameter `shift` in `translationFFT.m`.
* For evaluation, the variables `image name`, `coordiantes`, `displacement`, `strain` of a deformed image whose file name is `*.bmp` are saved in a file `*_dataRef.mat`, and these files are saved in the same folder.

## Questions & Suggestions
If you wish to contribute code/algorithms to this project, or have any question or suggestion, please contact Bin Chen (cbbuaa@outlook.com). 




