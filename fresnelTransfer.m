function diffraction_image = fresnelTransfer(object_image, plane_side_length,wavelength,propagation_distance)
%%performs fresnel transfer function of 2D image and returns irradiance
%%image
%Inputs:
%   object_image: the image of the object to be diffracted
%   plane_side_length: the length of the object plane (assumed square)
%   wavelength: the wavelength of the simluated monochromatic light
%   propagation distance: the distance between the object plane and the
%   observation plane
%
%Outputs:
%   diffraction_image: the irradiance image of the diffraction pattern

%get the pixel size of the object
[M,~] = size(object_image);
%get the sample size
dx = plane_side_length/M;
%for smallness
L = plane_side_length;
%create coordinates in frequency space
fx = -1/(2*dx):1/L:1/(2*dx)-1/L;
[FX,FY] = meshgrid(fx,fx);
%transfer function
H = exp(-1j*pi*wavelength*propagation_distance*(FX.^2+FY.^2));
%shift transfer function
H=fftshift(H);
%shift, fft object image 
Object_image = fft2(fftshift(object_image));
%convolution in fourier space
Diffraction_image = H.*Object_image;
%shift, ifft result
diffraction_image = ifftshift(ifft2(Diffraction_image));
%get irradiance image
diffraction_image = abs(diffraction_image).^2;
end
